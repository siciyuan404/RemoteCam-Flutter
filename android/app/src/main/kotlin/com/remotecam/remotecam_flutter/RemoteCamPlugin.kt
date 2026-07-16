package com.remotecam.remotecam_flutter

import android.content.Context
import android.graphics.SurfaceTexture
import android.view.Surface
import io.flutter.embedding.engine.renderer.FlutterRenderer
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.view.TextureRegistry
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class RemoteCamPlugin(
    private val context: Context,
    private val getFlutterRenderer: () -> FlutterRenderer?,
    private val getService: () -> RemoteCamService?
) : MethodChannel.MethodCallHandler {

    private var eventSink: EventChannel.EventSink? = null
    private var textureEntry: TextureRegistry.SurfaceTextureEntry? = null
    private val mainScope = CoroutineScope(Dispatchers.Main)

    companion object {
        private const val METHOD_CHANNEL = "remotecam/engine"
        private const val EVENT_CHANNEL = "remotecam/events"

        fun register(
            context: Context,
            messenger: io.flutter.plugin.common.BinaryMessenger,
            getFlutterRenderer: () -> FlutterRenderer?,
            getService: () -> RemoteCamService?
        ) {
            val plugin = RemoteCamPlugin(context, getFlutterRenderer, getService)
            val scope = CoroutineScope(Dispatchers.Main)

            MethodChannel(messenger, METHOD_CHANNEL).setMethodCallHandler(plugin)

            EventChannel(messenger, EVENT_CHANNEL).setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(args: Any?, sink: EventChannel.EventSink) {
                    plugin.eventSink = sink
                    val service = getService()
                    service?.onDataUpdated = { data ->
                        scope.launch {
                            plugin.eventSink?.success(mapOf("type" to "dataUpdated", "data" to data))
                        }
                    }
                    service?.onQuickDataUpdated = { dq ->
                        scope.launch {
                            plugin.eventSink?.success(mapOf("type" to "quickDataUpdated", "data" to dq))
                        }
                    }
                    service?.onPortBindError = { port ->
                        scope.launch {
                            plugin.eventSink?.success(mapOf("type" to "portBindError", "port" to port))
                        }
                    }
                }

                override fun onCancel(args: Any?) {
                    plugin.eventSink = null
                }
            })
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val service = getService()

        try {
            when (call.method) {
                // --- Engine lifecycle ---
                "startEngine" -> {
                    service?.startEngine()
                    result.success(null)
                }
                "stopEngine" -> {
                    service?.stopEngine()
                    result.success(null)
                }
                "initializeCamera" -> {
                    service?.engine?.initializeCamera()
                    result.success(null)
                }

                // --- Preview texture ---
                "createPreviewTexture" -> {
                    val renderer = getFlutterRenderer()
                    if (renderer == null) {
                        result.error("NO_RENDERER", "FlutterRenderer not available", null)
                        return
                    }
                    val entry = renderer.createSurfaceTexture()
                    textureEntry = entry
                    val surfaceTexture: SurfaceTexture = entry.surfaceTexture()
                    val surface = Surface(surfaceTexture)
                    service?.engine?.previewSurface = surface
                    result.success(entry.id())
                }
                "releasePreviewTexture" -> {
                    service?.engine?.previewSurface = null
                    textureEntry?.release()
                    textureEntry = null
                    result.success(null)
                }

                // --- View state ---
                "setViewState" -> {
                    val engine = service?.engine
                    if (engine == null) {
                        result.error("NO_ENGINE", "Engine not started", null)
                        return
                    }
                    val args = call.argument<Map<String, Any>>("state") ?: emptyMap()

                    val oldCameraId = engine.cameraId
                    val oldResolutionIndex = engine.resolutionIndex
                    val oldStreamFormat = engine.streamFormat
                    val oldH264Bitrate = engine.h264Bitrate
                    val oldH264Mode = engine.h264Mode
                    val oldFlash = engine.flash
                    val oldQuality = engine.quality
                    val oldFlashLevel = engine.flashLevel
                    val oldPreview = engine.preview
                    val oldStream = engine.stream

                    args["preview"]?.let { engine.preview = it as Boolean }
                    args["stream"]?.let { engine.stream = it as Boolean }
                    args["cameraId"]?.let { engine.cameraId = it as String }
                    args["resolutionIndex"]?.let {
                        engine.resolutionIndex = (it as Number).toInt().let { i -> if (i < 0) null else i }
                    }
                    args["quality"]?.let { engine.quality = (it as Number).toInt() }
                    args["flash"]?.let { engine.flash = it as Boolean }
                    args["flashLevel"]?.let { engine.flashLevel = (it as Number).toInt() }
                    args["streamFormat"]?.let { engine.streamFormat = (it as Number).toInt() }
                    args["h264Bitrate"]?.let { engine.h264Bitrate = (it as Number).toInt() }
                    args["h264Mode"]?.let { engine.h264Mode = (it as Number).toInt() }

                    // Determine what changed and act accordingly (mirrors original new_view_state logic)
                    val cameraChanged = engine.cameraId != oldCameraId
                    val resolutionChanged = engine.resolutionIndex != oldResolutionIndex
                    val streamFormatChanged = engine.streamFormat != oldStreamFormat
                    val previewChanged = engine.preview != oldPreview
                    val streamChanged = engine.stream != oldStream
                    val h264BitrateChanged = engine.h264Bitrate != oldH264Bitrate
                    val h264ModeChanged = engine.h264Mode != oldH264Mode
                    val flashChanged = engine.flash != oldFlash
                    val qualityChanged = engine.quality != oldQuality
                    val flashLevelChanged = engine.flashLevel != oldFlashLevel

                    val needsRestart = cameraChanged || resolutionChanged || previewChanged ||
                            streamFormatChanged || h264BitrateChanged || h264ModeChanged
                    val needsUpdateRequest = flashChanged || qualityChanged || flashLevelChanged

                    if (needsRestart) {
                        val disconnect = cameraChanged || resolutionChanged || streamFormatChanged
                        engine.restart(disconnect)
                    } else if (needsUpdateRequest) {
                        engine.updateRepeatingRequest()
                    }

                    // Save settings if remember is enabled
                    if (streamChanged || previewChanged || cameraChanged || resolutionChanged ||
                            qualityChanged || flashChanged || h264BitrateChanged || h264ModeChanged) {
                        saveViewStateToPrefs(engine)
                    }

                    result.success(null)
                }
                "getState" -> {
                    val engine = service?.engine
                    if (engine == null) {
                        result.success(null)
                    } else {
                        result.success(mapOf(
                            "preview" to engine.preview,
                            "stream" to engine.stream,
                            "cameraId" to engine.cameraId,
                            "resolutionIndex" to (engine.resolutionIndex ?: -1),
                            "quality" to engine.quality,
                            "flash" to engine.flash,
                            "flashLevel" to engine.flashLevel,
                            "streamFormat" to engine.streamFormat,
                            "h264Bitrate" to engine.h264Bitrate,
                            "h264Mode" to engine.h264Mode
                        ))
                    }
                }

                // --- Zoom ---
                "setZoomRatio" -> {
                    val r = (call.argument<Number>("ratio") ?: 0f).toFloat()
                    service?.engine?.setZoomRatio(r)
                    result.success(null)
                }
                "scaleZoom" -> {
                    val s = (call.argument<Number>("scale") ?: 1f).toFloat()
                    service?.engine?.scaleZoom(s)
                    result.success(null)
                }
                "stepZoomIn" -> { service?.engine?.stepZoomIn(); result.success(null) }
                "stepZoomOut" -> { service?.engine?.stepZoomOut(); result.success(null) }
                "toggleZoom" -> { service?.engine?.toggleZoom(); result.success(null) }

                // --- Flash ---
                "setFlashLevel" -> {
                    val level = (call.argument<Number>("level") ?: 1).toInt()
                    service?.engine?.setFlashLevel(level)
                    result.success(null)
                }
                "toggleFlash" -> { service?.engine?.toggleFlash(); result.success(null) }

                // --- Camera ---
                "switchToNextCamera" -> { service?.engine?.switchToNextCamera(); result.success(null) }

                // --- Stream format / H.264 ---
                "setStreamFormat" -> {
                    val f = (call.argument<Number>("format") ?: 0).toInt()
                    service?.engine?.setStreamFormat(f)
                    result.success(null)
                }
                "setH264Bitrate" -> {
                    val b = (call.argument<Number>("bitrate") ?: 10).toInt()
                    service?.engine?.setH264Bitrate(b)
                    result.success(null)
                }
                "setH264Mode" -> {
                    val m = (call.argument<Number>("mode") ?: 0).toInt()
                    service?.engine?.setH264Mode(m)
                    result.success(null)
                }

                // --- Camera parameters ---
                "setTargetFps" -> {
                    val fps = (call.argument<Number>("fps") ?: 30).toInt()
                    service?.engine?.setTargetFps(fps)
                    result.success(null)
                }
                "setAntiFlickerMode" -> {
                    val m = (call.argument<Number>("mode") ?: 0).toInt()
                    service?.engine?.setAntiFlickerMode(m)
                    result.success(null)
                }
                "setNoiseReductionMode" -> {
                    val m = (call.argument<Number>("mode") ?: 0).toInt()
                    service?.engine?.setNoiseReductionMode(m)
                    result.success(null)
                }
                "setStabilizationOff" -> {
                    val off = call.argument<Boolean>("off") ?: false
                    service?.engine?.setStabilizationOff(off)
                    result.success(null)
                }
                "setZoomSmoothingDelay" -> {
                    val d = (call.argument<Number>("delay") ?: 0).toInt()
                    service?.engine?.setZoomSmoothingDelay(d)
                    result.success(null)
                }

                // --- HTTP ---
                "setHttpPort" -> {
                    val port = (call.argument<Number>("port") ?: 8080).toInt()
                    service?.setHttpPort(port)
                    result.success(null)
                }
                "getHttpPort" -> {
                    result.success(SettingsManager.loadPort(context))
                }

                // --- Stream pause/resume ---
                "pauseStream" -> { service?.pauseStream(); result.success(null) }
                "resumeStream" -> { service?.resumeStream(); result.success(null) }

                // --- Network ---
                "getLocalIp" -> {
                    result.success(IpUtil.getLocalIpAddress())
                }

                // --- Settings get/set (pass-through to SettingsManager) ---
                "getSettings" -> {
                    result.success(getAllSettings())
                }
                "setSetting" -> {
                    val key = call.argument<String>("key") ?: ""
                    val value = call.argument<Any>("value")
                    if (value != null) setSetting(key, value)
                    result.success(null)
                }

                else -> result.notImplemented()
            }
        } catch (e: Exception) {
            result.error("ERROR", e.message, e.stackTraceToString())
        }
    }

    private fun saveViewStateToPrefs(engine: CamEngine) {
        val rememberSettings = SettingsManager.loadRememberSettings(context)
        if (!rememberSettings) return

        SettingsManager.getPrefs(context).edit().apply {
            putBoolean("preview", engine.preview)
            putBoolean("stream", engine.stream)
            if (SettingsManager.loadRememberSensor(context)) {
                putString("cameraId", engine.cameraId)
            }
            if (SettingsManager.loadRememberResolution(context)) {
                putInt("resolutionIndex", engine.resolutionIndex ?: -1)
            }
            if (SettingsManager.loadRememberQuality(context)) {
                putInt("quality", engine.quality)
            }
            if (SettingsManager.loadRememberFlash(context)) {
                putBoolean("flash_enabled", engine.flash)
                putInt("flash_level", engine.flashLevel)
            }
            if (SettingsManager.loadRememberH264(context)) {
                putInt("h264_bitrate", engine.h264Bitrate)
                putInt("h264_mode", engine.h264Mode)
            }
        }.apply()
    }

    private fun getAllSettings(): Map<String, Any> {
        val prefs = SettingsManager.getPrefs(context)
        return mapOf(
            "theme_mode" to prefs.getInt("theme_mode", SettingsManager.THEME_AUTO),
            "monet_enabled" to prefs.getBoolean("monet_enabled", true),
            "keep_screen_on" to prefs.getBoolean("keep_screen_on", false),
            "language_code" to (prefs.getString("language_code", "auto") ?: "auto"),
            "remember_settings" to prefs.getBoolean("remember_settings", true),
            "remember_flash" to prefs.getBoolean("remember_flash", true),
            "remember_zoom" to prefs.getBoolean("remember_zoom", true),
            "remember_sensor" to prefs.getBoolean("remember_sensor", true),
            "remember_resolution" to prefs.getBoolean("remember_resolution", true),
            "remember_quality" to prefs.getBoolean("remember_quality", true),
            "remember_h264" to prefs.getBoolean("remember_h264", true),
            "target_fps" to prefs.getInt("target_fps", 30),
            "double_tap_action" to prefs.getInt("double_tap_action", SettingsManager.DOUBLE_TAP_OFF),
            "stabilization_off" to prefs.getBoolean("stabilization_off", false),
            "anti_flicker_mode" to prefs.getInt("anti_flicker_mode", SettingsManager.ANTI_FLICKER_AUTO),
            "noise_reduction_mode" to prefs.getInt("noise_reduction_mode", SettingsManager.NR_AUTO),
            "volume_action" to prefs.getInt("volume_action", SettingsManager.VOL_ACTION_OFF),
            "auto_dim_delay" to prefs.getInt("auto_dim_delay", SettingsManager.DIM_DELAY_OFF),
            "lock_input_on_dim" to prefs.getBoolean("lock_input_on_dim", false),
            "background_streaming" to prefs.getBoolean("background_streaming", true),
            "allow_reconnects" to prefs.getBoolean("allow_reconnects", true),
            "zoom_smoothing_delay" to prefs.getInt("zoom_smoothing_delay", SettingsManager.SMOOTH_DELAY_NONE),
            "http_port" to prefs.getInt("http_port", SettingsManager.DEFAULT_PORT),
            "stream_format" to prefs.getInt("stream_format", SettingsManager.FORMAT_MJPEG)
        )
    }

    private fun setSetting(key: String, value: Any) {
        val prefs = SettingsManager.getPrefs(context)
        when (value) {
            is Boolean -> prefs.edit().putBoolean(key, value).apply()
            is Int -> prefs.edit().putInt(key, value).apply()
            is Long -> prefs.edit().putLong(key, value).apply()
            is Float -> prefs.edit().putFloat(key, value).apply()
            is String -> prefs.edit().putString(key, value).apply()
            is Number -> prefs.edit().putInt(key, value.toInt()).apply()
        }
    }
}
