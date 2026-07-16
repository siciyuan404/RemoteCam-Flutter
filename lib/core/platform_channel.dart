import 'dart:async';
import 'package:flutter/services.dart';

class SensorDesc {
  final String title;
  final String cameraId;
  final int format;
  SensorDesc({required this.title, required this.cameraId, required this.format});
  factory SensorDesc.fromMap(Map m) => SensorDesc(
    title: m['title'] as String,
    cameraId: m['cameraId'] as String,
    format: m['format'] as int,
  );
}

class Resolution {
  final int width;
  final int height;
  Resolution(this.width, this.height);
  factory Resolution.fromMap(Map m) => Resolution(m['width'] as int, m['height'] as int);
  @override
  String toString() => '${width}x$height';
}

class CameraData {
  final List<SensorDesc> sensors;
  final SensorDesc sensorSelected;
  final List<Resolution> resolutions;
  final int resolutionSelected;
  final double currentZoom;
  final double minZoom;
  final double maxZoom;
  final bool hasFlash;
  final int maxFlashLevel;
  final int quality;
  final bool flashState;
  final int flashLevel;
  final int sensorOrientation;

  CameraData({
    required this.sensors,
    required this.sensorSelected,
    required this.resolutions,
    required this.resolutionSelected,
    required this.currentZoom,
    required this.minZoom,
    required this.maxZoom,
    required this.hasFlash,
    required this.maxFlashLevel,
    required this.quality,
    required this.flashState,
    required this.flashLevel,
    required this.sensorOrientation,
  });

  factory CameraData.fromMap(Map m) => CameraData(
    sensors: (m['sensors'] as List).map((e) => SensorDesc.fromMap(e as Map)).toList(),
    sensorSelected: SensorDesc.fromMap(m['sensorSelected'] as Map),
    resolutions: (m['resolutions'] as List).map((e) => Resolution.fromMap(e as Map)).toList(),
    resolutionSelected: m['resolutionSelected'] as int,
    currentZoom: (m['currentZoom'] as num).toDouble(),
    minZoom: (m['minZoom'] as num).toDouble(),
    maxZoom: (m['maxZoom'] as num).toDouble(),
    hasFlash: m['hasFlash'] as bool,
    maxFlashLevel: m['maxFlashLevel'] as int,
    quality: m['quality'] as int,
    flashState: m['flashState'] as bool,
    flashLevel: m['flashLevel'] as int,
    sensorOrientation: m['sensorOrientation'] as int,
  );
}

class QuickData {
  final int ms;
  final int rateKbs;
  QuickData(this.ms, this.rateKbs);
  factory QuickData.fromMap(Map m) => QuickData(m['ms'] as int, m['rateKbs'] as int);
}

class ViewState {
  bool preview;
  bool stream;
  String cameraId;
  int resolutionIndex; // -1 = null/auto
  int quality;
  bool flash;
  int flashLevel;
  int streamFormat; // 0=MJPEG, 1=H264
  int h264Bitrate;
  int h264Mode;

  ViewState({
    this.preview = true,
    this.stream = false,
    this.cameraId = '0',
    this.resolutionIndex = -1,
    this.quality = 80,
    this.flash = false,
    this.flashLevel = -1,
    this.streamFormat = 0,
    this.h264Bitrate = 10,
    this.h264Mode = 0,
  });

  Map<String, dynamic> toMap() => {
    'preview': preview,
    'stream': stream,
    'cameraId': cameraId,
    'resolutionIndex': resolutionIndex,
    'quality': quality,
    'flash': flash,
    'flashLevel': flashLevel,
    'streamFormat': streamFormat,
    'h264Bitrate': h264Bitrate,
    'h264Mode': h264Mode,
  };
}

class RemoteCamChannel {
  static const _method = MethodChannel('remotecam/engine');
  static const _event = EventChannel('remotecam/events');

  static Stream<dynamic> get events => _event.receiveBroadcastStream();

  // Engine lifecycle
  static Future<void> startEngine() => _method.invokeMethod('startEngine');
  static Future<void> stopEngine() => _method.invokeMethod('stopEngine');
  static Future<void> initializeCamera() => _method.invokeMethod('initializeCamera');

  // Preview texture
  static Future<int> createPreviewTexture() async {
    final id = await _method.invokeMethod<int>('createPreviewTexture');
    return id ?? -1;
  }
  static Future<void> releasePreviewTexture() => _method.invokeMethod('releasePreviewTexture');

  // View state
  static Future<void> setViewState(ViewState state) =>
    _method.invokeMethod('setViewState', {'state': state.toMap()});
  static Future<Map?> getState() async {
    final result = await _method.invokeMethod('getState');
    return result as Map?;
  }

  // Zoom
  static Future<void> setZoomRatio(double ratio) =>
    _method.invokeMethod('setZoomRatio', {'ratio': ratio});
  static Future<void> scaleZoom(double scale) =>
    _method.invokeMethod('scaleZoom', {'scale': scale});
  static Future<void> stepZoomIn() => _method.invokeMethod('stepZoomIn');
  static Future<void> stepZoomOut() => _method.invokeMethod('stepZoomOut');
  static Future<void> toggleZoom() => _method.invokeMethod('toggleZoom');

  // Flash
  static Future<void> setFlashLevel(int level) =>
    _method.invokeMethod('setFlashLevel', {'level': level});
  static Future<void> toggleFlash() => _method.invokeMethod('toggleFlash');

  // Camera
  static Future<void> switchToNextCamera() => _method.invokeMethod('switchToNextCamera');

  // Stream format / H.264
  static Future<void> setStreamFormat(int format) =>
    _method.invokeMethod('setStreamFormat', {'format': format});
  static Future<void> setH264Bitrate(int bitrate) =>
    _method.invokeMethod('setH264Bitrate', {'bitrate': bitrate});
  static Future<void> setH264Mode(int mode) =>
    _method.invokeMethod('setH264Mode', {'mode': mode});

  // Camera parameters
  static Future<void> setTargetFps(int fps) =>
    _method.invokeMethod('setTargetFps', {'fps': fps});
  static Future<void> setAntiFlickerMode(int mode) =>
    _method.invokeMethod('setAntiFlickerMode', {'mode': mode});
  static Future<void> setNoiseReductionMode(int mode) =>
    _method.invokeMethod('setNoiseReductionMode', {'mode': mode});
  static Future<void> setStabilizationOff(bool off) =>
    _method.invokeMethod('setStabilizationOff', {'off': off});
  static Future<void> setZoomSmoothingDelay(int delay) =>
    _method.invokeMethod('setZoomSmoothingDelay', {'delay': delay});

  // HTTP
  static Future<void> setHttpPort(int port) =>
    _method.invokeMethod('setHttpPort', {'port': port});
  static Future<int> getHttpPort() async {
    final port = await _method.invokeMethod<int>('getHttpPort');
    return port ?? 8080;
  }

  // Stream pause/resume
  static Future<void> pauseStream() => _method.invokeMethod('pauseStream');
  static Future<void> resumeStream() => _method.invokeMethod('resumeStream');

  // Network
  static Future<String?> getLocalIp() => _method.invokeMethod<String>('getLocalIp');

  // Settings
  static Future<Map?> getSettings() async {
    final result = await _method.invokeMethod('getSettings');
    return result as Map?;
  }
  static Future<void> setSetting(String key, dynamic value) =>
    _method.invokeMethod('setSetting', {'key': key, 'value': value});
}
