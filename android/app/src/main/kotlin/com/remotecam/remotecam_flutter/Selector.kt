package com.remotecam.remotecam_flutter

import android.annotation.SuppressLint
import android.graphics.ImageFormat
import android.hardware.camera2.CameraCharacteristics
import android.hardware.camera2.CameraManager
import android.util.Log
import java.lang.Exception
import kotlin.math.atan
import kotlin.math.roundToInt

object Selector {
    // lensFacing: 0=Back, 1=Front, 2=External (mirrors CameraCharacteristics.LENS_FACING_*)
    data class SensorDesc(val title: String, val cameraId: String, val format: Int, val lensFacing: Int) {
        fun toMap(): Map<String, Any> = mapOf(
            "title" to title,
            "cameraId" to cameraId,
            "format" to format,
            "lensFacing" to lensFacing
        )
    }

    private fun lensOrientationString(value: Int) = when (value) {
        CameraCharacteristics.LENS_FACING_BACK -> "Back"
        CameraCharacteristics.LENS_FACING_FRONT -> "Front"
        CameraCharacteristics.LENS_FACING_EXTERNAL -> "External"
        else -> "Unknown"
    }

    @SuppressLint("InlinedApi")
    fun enumerateCameras(cameraManager: CameraManager): List<SensorDesc> {
        val availableCameras: MutableList<SensorDesc> = mutableListOf()

        val cameraIds = try {
            cameraManager.cameraIdList.toList()
        } catch (e: Exception) {
            Log.e("SELECTOR", "Fatal error getting camera ID list", e)
            return emptyList()
        }

        // Iterate through all cameras provided by the system, without any prior filtering.
        for (id in cameraIds) {
            try {
                val characteristics = cameraManager.getCameraCharacteristics(id)

                val lensFacing = characteristics.get(CameraCharacteristics.LENS_FACING)!!
                val orientation = lensOrientationString(lensFacing)

                val focalLengths = characteristics.get(CameraCharacteristics.LENS_INFO_AVAILABLE_FOCAL_LENGTHS)
                val apertures = characteristics.get(CameraCharacteristics.LENS_INFO_AVAILABLE_APERTURES)
                val sensorSize = characteristics.get(CameraCharacteristics.SENSOR_INFO_PHYSICAL_SIZE)

                val title: String

                // Try to build a technical name. If info is missing, use a fallback name.
                if (focalLengths != null && focalLengths.isNotEmpty() &&
                    apertures != null && apertures.isNotEmpty() &&
                    sensorSize != null) {

                    val foaclmm = focalLengths[0]
                    val foc = ("${foaclmm}mm").padEnd(6, ' ')
                    val ape = ("f${apertures[0]}").padEnd(4, ' ')
                    val vfov = ("${(2.0 * (180.0 / Math.PI) * atan(sensorSize.height / (2.0 * foaclmm))).roundToInt()}°").padEnd(4, ' ')

                    title = "vfov:$vfov $foc $ape $orientation"
                } else {
                    title = "Camera ID: $id ($orientation)"
                }

                // Add the camera if we don't already have another one with the exact same title.
                if (!availableCameras.any { it.title == title }) {
                    availableCameras.add(
                        SensorDesc(title, id, ImageFormat.JPEG, lensFacing)
                    )
                }

            } catch (e: Exception) {
                // If we can't read a camera's info, ignore it silently.
                // This is often a system or virtual camera not intended for third-party apps.
                Log.w("SELECTOR", "Could not process camera $id, skipping. Error: ${e.message}")
            }
        }

        // Sort the final list by camera ID for a consistent order.
        return availableCameras.sortedBy { it.cameraId.toIntOrNull() ?: Int.MAX_VALUE }
    }
}
