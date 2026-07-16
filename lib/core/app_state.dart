import 'dart:async';
import 'package:flutter/foundation.dart';
import 'platform_channel.dart';

class AppState extends ChangeNotifier {
  CameraData? camData;
  QuickData? quickData;
  ViewState viewState = ViewState();
  String? localIp;
  int httpPort = 8080;
  int? failedPort;
  bool showPortErrorDialog = false;

  // Settings
  int themeMode = 0; // 0=auto, 1=light, 2=dark
  bool monetEnabled = true;
  bool keepScreenOn = false;
  String languageCode = 'auto';
  bool rememberSettings = true;
  bool rememberFlash = true;
  bool rememberZoom = true;
  bool rememberSensor = true;
  bool rememberResolution = true;
  bool rememberQuality = true;
  bool rememberH264 = true;
  int targetFps = 30;
  int doubleTapAction = 0;
  bool stabilizationOff = false;
  int antiFlickerMode = 0;
  int noiseReductionMode = 0;
  int volumeAction = 0;
  int autoDimDelay = 0;
  bool lockInputOnDim = false;
  bool backgroundStreaming = true;
  bool allowReconnects = true;
  int zoomSmoothingDelay = 0;

  StreamSubscription? _eventSub;

  void startListening() {
    _eventSub?.cancel();
    _eventSub = RemoteCamChannel.events.listen((event) {
      if (event is! Map) return;
      final type = event['type'] as String;
      switch (type) {
        case 'dataUpdated':
          camData = CameraData.fromMap(event['data'] as Map);
          // Sync viewState from camData
          viewState.cameraId = camData!.sensorSelected.cameraId;
          viewState.resolutionIndex = camData!.resolutionSelected;
          viewState.quality = camData!.quality;
          viewState.flash = camData!.flashState;
          viewState.flashLevel = camData!.flashLevel;
          notifyListeners();
          break;
        case 'quickDataUpdated':
          quickData = QuickData.fromMap(event['data'] as Map);
          notifyListeners();
          break;
        case 'portBindError':
          failedPort = event['port'] as int;
          showPortErrorDialog = true;
          notifyListeners();
          break;
      }
    });
  }

  Future<void> loadSettings() async {
    final settings = await RemoteCamChannel.getSettings();
    if (settings == null) return;
    themeMode = settings['theme_mode'] as int;
    monetEnabled = settings['monet_enabled'] as bool;
    keepScreenOn = settings['keep_screen_on'] as bool;
    languageCode = settings['language_code'] as String;
    rememberSettings = settings['remember_settings'] as bool;
    rememberFlash = settings['remember_flash'] as bool;
    rememberZoom = settings['remember_zoom'] as bool;
    rememberSensor = settings['remember_sensor'] as bool;
    rememberResolution = settings['remember_resolution'] as bool;
    rememberQuality = settings['remember_quality'] as bool;
    rememberH264 = settings['remember_h264'] as bool;
    targetFps = settings['target_fps'] as int;
    doubleTapAction = settings['double_tap_action'] as int;
    stabilizationOff = settings['stabilization_off'] as bool;
    antiFlickerMode = settings['anti_flicker_mode'] as int;
    noiseReductionMode = settings['noise_reduction_mode'] as int;
    volumeAction = settings['volume_action'] as int;
    autoDimDelay = settings['auto_dim_delay'] as int;
    lockInputOnDim = settings['lock_input_on_dim'] as bool;
    backgroundStreaming = settings['background_streaming'] as bool;
    allowReconnects = settings['allow_reconnects'] as bool;
    zoomSmoothingDelay = settings['zoom_smoothing_delay'] as int;
    httpPort = settings['http_port'] as int;
    viewState.streamFormat = settings['stream_format'] as int;
    notifyListeners();
  }

  Future<void> loadLocalIp() async {
    localIp = await RemoteCamChannel.getLocalIp();
    notifyListeners();
  }

  Future<void> updateSetting(String key, dynamic value) async {
    await RemoteCamChannel.setSetting(key, value);
    // Update local state
    switch (key) {
      case 'theme_mode': themeMode = value as int; break;
      case 'monet_enabled': monetEnabled = value as bool; break;
      case 'keep_screen_on': keepScreenOn = value as bool; break;
      case 'language_code': languageCode = value as String; break;
      case 'remember_settings': rememberSettings = value as bool; break;
      case 'remember_flash': rememberFlash = value as bool; break;
      case 'remember_zoom': rememberZoom = value as bool; break;
      case 'remember_sensor': rememberSensor = value as bool; break;
      case 'remember_resolution': rememberResolution = value as bool; break;
      case 'remember_quality': rememberQuality = value as bool; break;
      case 'remember_h264': rememberH264 = value as bool; break;
      case 'target_fps': targetFps = value as int; break;
      case 'double_tap_action': doubleTapAction = value as int; break;
      case 'stabilization_off': stabilizationOff = value as bool; break;
      case 'anti_flicker_mode': antiFlickerMode = value as int; break;
      case 'noise_reduction_mode': noiseReductionMode = value as int; break;
      case 'volume_action': volumeAction = value as int; break;
      case 'auto_dim_delay': autoDimDelay = value as int; break;
      case 'lock_input_on_dim': lockInputOnDim = value as bool; break;
      case 'background_streaming': backgroundStreaming = value as bool; break;
      case 'allow_reconnects': allowReconnects = value as bool; break;
      case 'zoom_smoothing_delay': zoomSmoothingDelay = value as int; break;
      case 'http_port': httpPort = value as int; break;
      case 'stream_format': viewState.streamFormat = value as int; break;
    }
    notifyListeners();
  }

  String get streamUrl {
    final ip = localIp ?? '?';
    final endpoint = viewState.streamFormat == 0 ? 'cam.mjpeg' : 'cam.h264';
    return '$ip:$httpPort/$endpoint';
  }

  @override
  void dispose() {
    _eventSub?.cancel();
    super.dispose();
  }
}
