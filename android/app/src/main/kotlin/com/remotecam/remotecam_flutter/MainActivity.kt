package com.remotecam.remotecam_flutter

import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.ServiceConnection
import android.os.Build
import android.os.Bundle
import android.os.IBinder
import android.view.KeyEvent
import android.view.WindowManager
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {

    private var serviceBinder: RemoteCamService.LocalBinder? = null

    private val serviceConnection = object : ServiceConnection {
        override fun onServiceConnected(name: ComponentName?, binder: IBinder?) {
            serviceBinder = binder as? RemoteCamService.LocalBinder
        }
        override fun onServiceDisconnected(name: ComponentName?) {
            serviceBinder = null
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Start and bind the foreground service
        val intent = Intent(this, RemoteCamService::class.java)
        ContextCompat.startForegroundService(this, intent)
        bindService(intent, serviceConnection, Context.BIND_AUTO_CREATE)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        RemoteCamPlugin.register(
            this,
            flutterEngine.dartExecutor.binaryMessenger,
            { flutterEngine.renderer },
            { serviceBinder?.getService() }
        )
    }

    override fun onResume() {
        super.onResume()
        // Apply keep-screen-on setting
        if (SettingsManager.loadKeepScreenOn(this)) {
            window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        } else {
            window.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        }
        // Resume streaming
        serviceBinder?.getService()?.resumeStream()
    }

    override fun onPause() {
        super.onPause()
        val service = serviceBinder?.getService()
        if (service != null && !SettingsManager.loadBackgroundStreaming(this)) {
            service.pauseStream()
        }
    }

    override fun onDestroy() {
        try { unbindService(serviceConnection) } catch (_: Exception) {}
        super.onDestroy()
    }

    // Volume key custom actions
    override fun onKeyDown(keyCode: Int, event: KeyEvent?): Boolean {
        val action = SettingsManager.loadVolumeAction(this)
        if (action == SettingsManager.VOL_ACTION_OFF) {
            return super.onKeyDown(keyCode, event)
        }
        val engine = serviceBinder?.getService()?.engine ?: return super.onKeyDown(keyCode, event)

        when (keyCode) {
            KeyEvent.KEYCODE_VOLUME_UP -> {
                when (action) {
                    SettingsManager.VOL_ACTION_ZOOM -> engine.stepZoomIn()
                    SettingsManager.VOL_ACTION_SWITCH_CAM -> engine.switchToNextCamera()
                    SettingsManager.VOL_ACTION_TOGGLE_FLASH -> engine.toggleFlash()
                }
                return true
            }
            KeyEvent.KEYCODE_VOLUME_DOWN -> {
                when (action) {
                    SettingsManager.VOL_ACTION_ZOOM -> engine.stepZoomOut()
                    SettingsManager.VOL_ACTION_SWITCH_CAM -> engine.switchToNextCamera()
                    SettingsManager.VOL_ACTION_TOGGLE_FLASH -> engine.toggleFlash()
                }
                return true
            }
        }
        return super.onKeyDown(keyCode, event)
    }
}
