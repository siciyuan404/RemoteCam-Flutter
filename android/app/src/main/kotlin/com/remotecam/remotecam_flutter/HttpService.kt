package com.remotecam.remotecam_flutter

import io.ktor.http.ContentType
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.*
import io.ktor.server.engine.*
import io.ktor.server.netty.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.utils.io.*
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.channels.consumeEach
import java.io.OutputStream
import io.netty.channel.ChannelOption
import io.netty.bootstrap.ServerBootstrap
import java.net.BindException
import java.util.concurrent.CopyOnWriteArrayList

data class H264Frame(val data: ByteArray, val isKeyFrame: Boolean)

class ClientSession {
    val channel = Channel<H264Frame>(capacity = 60)
    var needsKeyframe = true
}

class HttpService {
    private lateinit var engine: NettyApplicationEngine
    private lateinit var imageChannel: Channel<ByteArray>

    private val h264Clients = CopyOnWriteArrayList<ClientSession>()
    private var currentPort: Int = 0

    var onPortBindError: ((Int) -> Unit)? = null

    private fun producer(): suspend OutputStream.() -> Unit = {
        val outputStream = this
        try {
            imageChannel.consumeEach { frameData ->
                outputStream.write("--FRAME\r\nContent-Type: image/jpeg\r\n\r\n".toByteArray())
                outputStream.write(frameData)
                outputStream.flush()
            }
        } catch (_: Exception) {}
    }

    fun start(port: Int = currentPort) {
        if (port != 0) currentPort = port
        imageChannel = Channel(Channel.CONFLATED)

        // 1. Define the server
        engine = embeddedServer(Netty, port = currentPort, configure = {
            configureBootstrap = { bootstrap: ServerBootstrap ->
                bootstrap.option(ChannelOption.TCP_NODELAY, true)
                bootstrap.option(ChannelOption.SO_KEEPALIVE, true)
            }
            responseWriteTimeoutSeconds = 10
        }) {
            routing {
                get("/cam") {
                    call.respondText("Ok")
                }
                get("/cam.mjpeg") {
                    call.respondOutputStream(
                        contentType = ContentType.parse("multipart/x-mixed-replace;boundary=FRAME"),
                        status = HttpStatusCode.OK,
                        producer = producer()
                    )
                }
                get("/cam.h264") {
                    val session = ClientSession()
                    h264Clients.add(session)
                    try {
                        call.respondBytesWriter(contentType = ContentType.parse("video/h264")) {
                            session.channel.consumeEach { frame ->
                                writeFully(frame.data)
                                flush()
                            }
                        }
                    } catch (e: Exception) {
                        // Client disconnected
                    } finally {
                        h264Clients.remove(session)
                        session.channel.close()
                    }
                }
            }
        }

        // 2. Try to start it (This is where we put the try-catch!)
        try {
            engine.start(wait = false)
        } catch (e: Exception) {
            // If the port is already taken, Netty throws a BindException or an exception with BindException as cause
            if (e is BindException || e.cause is BindException) {
                onPortBindError?.invoke(currentPort)
            }
            e.printStackTrace()
            stop() // Clean up
        }
    }

    fun stop() {
        if (::engine.isInitialized) {
            disconnectClients()
            try { engine.stop(100, 100) } catch (_: Exception) {}
        }
    }

    fun restartServer(newPort: Int) {
        if (newPort == currentPort) return
        stop()
        currentPort = newPort
        start()
    }

    fun sendFrame(bytes: ByteArray) {
        if (::imageChannel.isInitialized) imageChannel.trySend(bytes)
    }

    fun sendH264Frame(bytes: ByteArray, isKeyFrame: Boolean) {
        for (client in h264Clients) {
            if (client.needsKeyframe && !isKeyFrame) continue
            val result = client.channel.trySend(H264Frame(bytes, isKeyFrame))
            if (!result.isSuccess) {
                while (client.channel.tryReceive().isSuccess) { }
                client.needsKeyframe = true
                if (isKeyFrame) {
                    client.channel.trySend(H264Frame(bytes, true))
                    client.needsKeyframe = false
                }
            } else {
                client.needsKeyframe = false
            }
        }
    }

    fun disconnectClients() {
        for (client in h264Clients) {
            client.channel.close()
        }
        h264Clients.clear()
    }
}
