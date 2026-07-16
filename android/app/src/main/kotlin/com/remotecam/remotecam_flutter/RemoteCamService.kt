package com.remotecam.remotecam_flutter

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Binder
import android.os.Build
import android.os.IBinder
import androidx.core.app.NotificationCompat

class RemoteCamService : Service() {

    companion object {
        private const val NOTIFICATION_ID = 123
        private const val CHANNEL_ID = "REMOTE_CAM"
    }

    var engine: CamEngine? = null
    var http: HttpService? = null

    // Callbacks (set by RemoteCamPlugin)
    var onDataUpdated: ((Map<String, Any>) -> Unit)? = null
    var onQuickDataUpdated: ((Map<String, Any>) -> Unit)? = null
    var onPortBindError: ((Int) -> Unit)? = null

    private val binder = LocalBinder()

    inner class LocalBinder : Binder() {
        fun getService(): RemoteCamService = this@RemoteCamService
    }

    override fun onBind(intent: Intent?): IBinder = binder

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        createNotificationChannel()
        startForeground(NOTIFICATION_ID, createNotification())
        return START_STICKY
    }

    fun startEngine() {
        if (http == null) {
            val port = SettingsManager.loadPort(this)
            http = HttpService()
            http?.onPortBindError = { p -> onPortBindError?.invoke(p) }
            try {
                http?.start(port)
            } catch (e: Exception) {
                onPortBindError?.invoke(port)
            }
        }
        if (engine == null) {
            engine = CamEngine(
                this,
                SettingsManager.loadTargetFps(this),
                SettingsManager.loadAntiFlickerMode(this),
                SettingsManager.loadNoiseReductionMode(this),
                SettingsManager.loadStabilizationOff(this)
            )
            engine?.http = http
            engine?.onDataUpdated = { data -> onDataUpdated?.invoke(data.toMap()) }
            engine?.onQuickDataUpdated = { dq -> onQuickDataUpdated?.invoke(dq.toMap()) }
        }
    }

    fun stopEngine() {
        engine?.destroy()
        engine = null
        http?.stop()
        http = null
        stopForeground(STOP_FOREGROUND_REMOVE)
        stopSelf()
    }

    fun setHttpPort(newPort: Int) {
        http?.restartServer(newPort)
        SettingsManager.savePort(this, newPort)
    }

    fun pauseStream() {
        engine?.insidePause = true
    }

    fun resumeStream() {
        engine?.insidePause = false
    }

    private fun createNotificationChannel() {
        val channel = NotificationChannel(
            CHANNEL_ID,
            "REMOTE_CAM",
            NotificationManager.IMPORTANCE_DEFAULT
        )
        val manager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        manager.createNotificationChannel(channel)
    }

    private fun createNotification(): Notification {
        val contentIntent = Intent(this, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_SINGLE_TOP or Intent.FLAG_ACTIVITY_CLEAR_TOP
        }
        val contentPendingIntent = PendingIntent.getActivity(
            this, 0, contentIntent,
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
        )

        val killIntent = Intent(this, RemoteCamService::class.java).apply {
            action = "KILL"
        }
        val killPendingIntent = PendingIntent.getService(
            this, 1, killIntent,
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
        )

        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle(getString(R.string.notif_title))
            .setContentText(getString(R.string.notif_text))
            .setSmallIcon(R.drawable.ic_linked_camera)
            .setOngoing(true)
            .setContentIntent(contentPendingIntent)
            .addAction(R.drawable.ic_close, getString(R.string.notif_kill), killPendingIntent)
            .build()
    }
}
