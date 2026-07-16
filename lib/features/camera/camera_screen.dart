import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remotecam_flutter/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app.dart';
import '../../core/app_state.dart';
import '../../core/platform_channel.dart';
import '../settings/widgets/settings_widgets.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  static const _repoUrl = 'https://github.com/alan7383/RemoteCam-Enhanced';
  static const _repoLabel = 'github.com/alan7383/RemoteCam-Enhanced';
  static const _qualities = <int>[1, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100];

  AppState? _appState;
  int _textureId = -1;
  bool _initialized = false;
  bool _portDialogShowing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      _appState = RemoteCamApp.of(context).appState;
      _appState!.addListener(_onAppStateChanged);
      _initCamera();
    }
  }

  Future<void> _initCamera() async {
    try {
      await RemoteCamChannel.startEngine();
      _textureId = await RemoteCamChannel.createPreviewTexture();
      await RemoteCamChannel.initializeCamera();
      await _appState!.loadLocalIp();
    } catch (_) {
      // Best-effort init; native side will report errors via events.
    }
    if (mounted) setState(() {});
  }

  void _onAppStateChanged() {
    if (!mounted) return;
    final appState = _appState;
    if (appState == null) return;
    if (appState.showPortErrorDialog && !_portDialogShowing) {
      _portDialogShowing = true;
      appState.showPortErrorDialog = false;
      _showPortErrorDialog();
    }
  }

  @override
  void dispose() {
    _appState?.removeListener(_onAppStateChanged);
    RemoteCamChannel.releasePreviewTexture();
    super.dispose();
  }

  Future<void> _pushViewState() async {
    final appState = _appState;
    if (appState == null) return;
    await RemoteCamChannel.setViewState(appState.viewState);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    appState.notifyListeners();
  }

  void _showPortErrorDialog() {
    final l = AppLocalizations.of(context)!;
    final appState = _appState!;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Text(l.error_port_title),
        content: Text(l.error_port_message(appState.failedPort ?? 0)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              _portDialogShowing = false;
            },
            child: Text(l.settings_close),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              _portDialogShowing = false;
              _showPortChangeDialog();
            },
            child: Text(l.btn_change_port),
          ),
        ],
      ),
    );
  }

  void _showPortChangeDialog() {
    final l = AppLocalizations.of(context)!;
    final controller = TextEditingController();
    String? errorText;
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setState) => AlertDialog(
            title: Text(l.settings_port_dialog_title),
            content: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: InputDecoration(
                labelText: l.settings_port_dialog_label,
                errorText: errorText,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(l.settings_close),
              ),
              TextButton(
                onPressed: () {
                  final port = int.tryParse(controller.text.trim());
                  if (port == null || port < 1025 || port > 65535) {
                    setState(() => errorText = l.settings_port_dialog_invalid);
                  } else {
                    Navigator.pop(ctx);
                    _appState!.updateSetting('http_port', port);
                    RemoteCamChannel.setHttpPort(port);
                  }
                },
                child: Text(l.settings_save),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final appState = _appState;

    if (appState == null) {
      return Scaffold(
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final camData = appState.camData;
        final viewState = appState.viewState;
        final quickData = appState.quickData;

        final statsText = viewState.streamFormat == 1
            ? '${quickData?.rateKbs ?? 0} kB/s'
            : '${quickData?.ms ?? 0}ms / ${quickData?.rateKbs ?? 0} kB/s';

        return Scaffold(
          appBar: AppBar(
            title: Text(
              l.app_name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: cs.surface,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: Text(
                    statsText,
                    style: TextStyle(
                      color: cs.primary,
                      fontSize: Theme.of(context).textTheme.labelLarge?.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              IconButton.filledTonal(
                onPressed: () => Navigator.pushNamed(context, '/settings'),
                icon: const Icon(Icons.settings),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      color: Colors.black,
                      child: _buildPreview(viewState),
                    ),
                  ),
                ),
              ),
              if (camData != null)
                _buildQuickToolbar(l, camData, viewState, appState),
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 16, bottom: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildControlsGroup(l, camData, viewState),
                      const SizedBox(height: 24),
                      if (camData != null) ...[
                        _buildParametersGroup(l, camData, viewState),
                        const SizedBox(height: 24),
                      ],
                      _buildInformationGroup(l, appState),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await RemoteCamChannel.stopEngine();
              if (mounted) {
                SystemNavigator.pop();
              }
            },
            icon: const Icon(Icons.videocam),
            label: Text(l.cam_stop),
            backgroundColor: cs.errorContainer,
            foregroundColor: cs.onErrorContainer,
          ),
        );
      },
    );
  }

  /// Quick toolbar below preview: camera switch / aspect ratio / frame rate.
  Widget _buildQuickToolbar(
      AppLocalizations l, CameraData camData, ViewState viewState, AppState appState) {
    final cs = Theme.of(context).colorScheme;

    // --- Aspect ratio logic ---
    // Compute available ratios from current sensor's resolutions.
    final ratios = <String>{}; // preserve insertion order
    final ratioBuckets = <String, List<int>>{}; // ratio -> list of resolution indexes
    for (var i = 0; i < camData.resolutions.length; i++) {
      final r = camData.resolutions[i];
      final ratio = _aspectRatioLabel(r.width, r.height);
      ratios.add(ratio);
      (ratioBuckets[ratio] ??= []).add(i);
    }
    final availableRatios = ratios.toList();

    // Current ratio derived from selected resolution.
    final currentResIdx = viewState.resolutionIndex >= 0 &&
            viewState.resolutionIndex < camData.resolutions.length
        ? viewState.resolutionIndex
        : camData.resolutionSelected;
    final currentRatio = currentResIdx >= 0 && currentResIdx < camData.resolutions.length
        ? _aspectRatioLabel(
            camData.resolutions[currentResIdx].width, camData.resolutions[currentResIdx].height)
        : availableRatios.isNotEmpty ? availableRatios.first : '4:3';

    // --- FPS logic ---
    const fpsOptions = [24, 30, 60];
    final currentFps = appState.targetFps;

    // --- Camera facing switch ---
    final hasFrontCam = camData.sensors.any((s) => s.lensFacing == 1);
    final currentSensor = camData.sensors.firstWhere(
      (s) => s.cameraId == camData.sensorSelected.cameraId,
      orElse: () => camData.sensors.first,
    );
    final isFront = currentSensor.lensFacing == 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 0,
        color: cs.surfaceContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            children: [
              // Camera switch button
              if (camData.sensors.length > 1)
                Tooltip(
                  message: isFront ? 'Front camera' : 'Back camera',
                  child: IconButton.filledTonal(
                    onPressed: () async {
                      if (hasFrontCam) {
                        // Switch to next camera with different facing.
                        final targetFacing = isFront ? 0 : 1;
                        final next = camData.sensors.firstWhere(
                          (s) => s.lensFacing == targetFacing,
                          orElse: () => camData.sensors.first,
                        );
                        viewState.cameraId = next.cameraId;
                        viewState.resolutionIndex = -1; // auto
                        await _pushViewState();
                      } else {
                        // No front camera; just cycle to next sensor.
                        await RemoteCamChannel.switchToNextCamera();
                      }
                    },
                    icon: Icon(
                      isFront ? Icons.camera_rear : Icons.camera_front,
                    ),
                  ),
                ),
              if (camData.sensors.length > 1) const SizedBox(width: 4),

              // Aspect ratio chips
              if (availableRatios.length > 1) ...[
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: availableRatios.map((ratio) {
                        final selected = ratio == currentRatio;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: ChoiceChip(
                            label: Text(ratio),
                            selected: selected,
                            onSelected: (_) async {
                              final bucket = ratioBuckets[ratio];
                              if (bucket == null || bucket.isEmpty) return;
                              // Pick the largest resolution (first in reversed-sorted list).
                              viewState.resolutionIndex = bucket.first;
                              await _pushViewState();
                            },
                            visualDensity: VisualDensity.compact,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
              ] else
                const Spacer(),

              // FPS chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: fpsOptions.map((fps) {
                    final selected = fps == currentFps;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: ChoiceChip(
                        label: Text('$fps'),
                        selected: selected,
                        onSelected: (_) async {
                          await appState.updateTargetFps(fps);
                        },
                        visualDensity: VisualDensity.compact,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Returns "4:3", "16:9", "1:1" or a raw "W:H" fallback.
  String _aspectRatioLabel(int w, int h) {
    if (h == 0) return '?';
    final ratio = w / h;
    if ((ratio - 4 / 3).abs() < 0.02) return '4:3';
    if ((ratio - 16 / 9).abs() < 0.02) return '16:9';
    if ((ratio - 1.0).abs() < 0.02) return '1:1';
    // Fallback: reduced W:H
    final gcd = _gcd(w, h);
    return '${w ~/ gcd}:${h ~/ gcd}';
  }

  int _gcd(int a, int b) {
    while (b != 0) {
      final t = b;
      b = a % b;
      a = t;
    }
    return a;
  }

  Widget _buildPreview(ViewState viewState) {
    if (_textureId < 0) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white70),
      );
    }
    if (!viewState.preview) {
      return const Center(
        child: Text(
          'Preview is off',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }
    return GestureDetector(
      onDoubleTap: () {
        final action = _appState?.doubleTapAction ?? 0;
        switch (action) {
          case 1:
            RemoteCamChannel.switchToNextCamera();
            break;
          case 2:
            RemoteCamChannel.toggleZoom();
            break;
        }
      },
      onScaleUpdate: (details) {
        if (details.scale != 1.0) {
          RemoteCamChannel.scaleZoom(details.scale);
        }
      },
      child: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: Texture(textureId: _textureId),
        ),
      ),
    );
  }

  Widget _buildControlsGroup(
      AppLocalizations l, CameraData? camData, ViewState viewState) {
    final children = <Widget>[];

    children.add(SettingsItem(
      icon: Icons.visibility,
      title: l.cam_local_preview,
      hasSwitch: true,
      switchState: viewState.preview,
      onSwitchChange: (v) async {
        viewState.preview = v;
        await _pushViewState();
      },
    ));

    children.add(SettingsItem(
      icon: Icons.cell_tower,
      title: l.cam_mjpeg_stream,
      hasSwitch: true,
      switchState: viewState.stream,
      onSwitchChange: (v) async {
        viewState.stream = v;
        await _pushViewState();
      },
    ));

    if (camData?.hasFlash == true) {
      final data = camData!;
      children.add(SettingsItem(
        icon: Icons.flash_on,
        title: l.cam_flash,
        hasSwitch: true,
        switchState: data.flashState,
        onSwitchChange: (_) async {
          await RemoteCamChannel.toggleFlash();
        },
      ));

      if (data.flashState && data.maxFlashLevel > 1) {
        children.add(SettingsIntegerSliderItem(
          icon: Icons.tungsten,
          title: l.cam_flash_level,
          value: data.flashLevel.clamp(1, data.maxFlashLevel),
          min: 1,
          max: data.maxFlashLevel,
          divisions: data.maxFlashLevel - 1,
          onChanged: (v) async {
            viewState.flashLevel = v;
            await _pushViewState();
          },
        ));
      }
    }

    return SettingsGroup(title: l.cam_controls, children: children);
  }

  Widget _buildParametersGroup(
      AppLocalizations l, CameraData camData, ViewState viewState) {
    final children = <Widget>[];

    // Sensor dropdown
    final sensorIdx = camData.sensors
        .indexWhere((s) => s.cameraId == camData.sensorSelected.cameraId);
    final selectedSensor = sensorIdx >= 0 ? sensorIdx : 0;
    children.add(SettingsDropdownItem<int>(
      icon: Icons.camera_alt,
      title: l.cam_sensor,
      selected: selectedSensor,
      options: List<int>.generate(camData.sensors.length, (i) => i),
      labelBuilder: (i) => camData.sensors[i].title,
      onChanged: (i) async {
        viewState.cameraId = camData.sensors[i].cameraId;
        await _pushViewState();
      },
    ));

    // Resolution dropdown
    final selectedRes =
        (viewState.resolutionIndex >= 0 && viewState.resolutionIndex < camData.resolutions.length)
            ? viewState.resolutionIndex
            : camData.resolutionSelected;
    children.add(SettingsDropdownItem<int>(
      icon: Icons.photo_size_select_actual,
      title: l.cam_resolution,
      selected: selectedRes,
      options: List<int>.generate(camData.resolutions.length, (i) => i),
      labelBuilder: (i) => camData.resolutions[i].toString(),
      onChanged: (i) async {
        viewState.resolutionIndex = i;
        await _pushViewState();
      },
    ));

    if (viewState.streamFormat == 1) {
      // H.264 mode
      children.add(SettingsIntegerSliderItem(
        icon: Icons.speed,
        title: l.h264_bitrate,
        value: viewState.h264Bitrate.clamp(1, 100),
        min: 1,
        max: 100,
        divisions: 98,
        onReset: () async {
          viewState.h264Bitrate = 10;
          await _pushViewState();
        },
        onChanged: (v) async {
          viewState.h264Bitrate = v;
          await _pushViewState();
        },
      ));

      children.add(SettingsDropdownItem<int>(
        icon: Icons.tune,
        title: l.h264_mode,
        selected: viewState.h264Mode,
        options: const [0, 1],
        labelBuilder: (m) => m == 0 ? l.h264_mode_cbr : l.h264_mode_vbr,
        onChanged: (m) async {
          viewState.h264Mode = m;
          await _pushViewState();
        },
      ));
    } else {
      // MJPEG mode - JPEG quality
      final selectedQ =
          _qualities.contains(viewState.quality) ? viewState.quality : 80;
      children.add(SettingsDropdownItem<int>(
        icon: Icons.high_quality,
        title: l.cam_quality,
        selected: selectedQ,
        options: _qualities,
        labelBuilder: (q) => '$q%',
        onChanged: (q) async {
          viewState.quality = q;
          await _pushViewState();
        },
      ));
    }

    // Zoom slider (only when camera supports zoom range)
    if (camData.maxZoom > camData.minZoom) {
      children.add(SettingsSliderItem(
        icon: Icons.zoom_in,
        title: 'Zoom',
        value: camData.currentZoom.clamp(camData.minZoom, camData.maxZoom),
        min: camData.minZoom,
        max: camData.maxZoom,
        onChanged: (v) async {
          double value = v;
          if ((value - 1.0).abs() < 0.12) {
            value = 1.0;
            await HapticFeedback.vibrate();
          }
          final range = camData.maxZoom - camData.minZoom;
          final ratio = range > 0 ? (value - camData.minZoom) / range : 0.0;
          await RemoteCamChannel.setZoomRatio(ratio.clamp(0.0, 1.0));
        },
      ));
    }

    return SettingsGroup(title: l.cam_parameters, children: children);
  }

  Widget _buildInformationGroup(AppLocalizations l, AppState appState) {
    return SettingsGroup(
      title: l.cam_information,
      children: [
        SettingsItem(
          icon: Icons.link,
          title: 'Stream URL',
          subtitle: appState.streamUrl,
          onClick: () {
            Clipboard.setData(ClipboardData(text: appState.streamUrl));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l.cam_clipboard_copied)),
            );
          },
        ),
        SettingsItem(
          icon: Icons.code,
          title: 'GitHub',
          subtitle: _repoLabel,
          onClick: () {
            launchUrl(Uri.parse(_repoUrl));
          },
        ),
      ],
    );
  }
}
