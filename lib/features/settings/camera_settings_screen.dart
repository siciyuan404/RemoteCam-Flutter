import 'package:flutter/material.dart';
import 'package:remotecam_flutter/l10n/app_localizations.dart';
import '../../app.dart';
import '../../core/app_state.dart';
import '../../core/platform_channel.dart';
import 'widgets/settings_widgets.dart';

class CameraSettingsScreen extends StatelessWidget {
  const CameraSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final appState = RemoteCamApp.of(context).appState;
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final formatOptions = <int, String>{
          0: l.settings_format_mjpeg,
          1: l.settings_format_h264,
        };
        final formatSubtitles = <int, String>{
          0: l.settings_format_mjpeg_desc,
          1: l.settings_format_h264_desc,
        };
        final fpsOptions = <int, String>{
          15: '15 FPS',
          24: '24 FPS',
          30: '30 FPS',
          60: '60 FPS',
        };
        final doubleTapOptions = <int, String>{
          0: l.settings_double_tap_off,
          1: l.settings_double_tap_switch_cam,
          2: l.settings_double_tap_toggle_zoom,
        };
        final flickerOptions = <int, String>{
          0: l.settings_flicker_auto,
          1: l.settings_flicker_off,
          2: l.settings_flicker_50hz,
          3: l.settings_flicker_60hz,
        };
        final noiseOptions = <int, String>{
          0: l.settings_noise_reduction_auto,
          1: l.settings_noise_reduction_off,
          2: l.settings_noise_reduction_low,
          3: l.settings_noise_reduction_high,
        };
        final volumeOptions = <int, String>{
          0: l.settings_volume_action_off,
          1: l.settings_volume_action_zoom,
          2: l.settings_volume_action_switch_cam,
          3: l.settings_volume_action_toggle_flash,
        };
        final zoomSmoothingOptions = <int, String>{
          0: l.settings_zoom_smoothing_none,
          5: '5ms',
          8: '8ms',
          10: '10ms',
          15: '15ms',
          20: '20ms',
          25: '25ms',
          30: '30ms',
          40: '40ms',
          50: '50ms',
        };
        return SettingsScaffold(
          title: l.settings_camera_title,
          body: ListView(
            padding: const EdgeInsets.only(bottom: 16),
            children: [
              SettingsGroup(
                title: l.settings_camera_title,
                children: [
                  SettingsItem(
                    icon: Icons.memory,
                    title: l.settings_remember_title,
                    subtitle: l.settings_remember_desc,
                    hasSwitch: true,
                    switchState: appState.rememberSettings,
                    onSwitchChange: (value) =>
                        appState.updateSetting('remember_settings', value),
                    onClick: () {
                      if (appState.rememberSettings) {
                        showDialog(
                          context: context,
                          builder: (ctx) =>
                              RememberSettingsDialog(appState: appState),
                        );
                      } else {
                        appState.updateSetting('remember_settings', true);
                      }
                    },
                  ),
                  SettingsItem(
                    icon: Icons.videocam,
                    title: l.settings_format_title,
                    subtitle: l.settings_format_desc,
                    showBetaBadge: true,
                    onClick: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => SettingsRadioDialog<int>(
                          title: l.settings_format_title,
                          options: formatOptions,
                          subtitles: formatSubtitles,
                          selected: appState.viewState.streamFormat,
                          betaItem: 1,
                          onConfirm: (value) {
                            appState.updateSetting('stream_format', value);
                            RemoteCamChannel.setStreamFormat(value);
                          },
                        ),
                      );
                    },
                  ),
                  SettingsItem(
                    icon: Icons.speed,
                    title: l.settings_fps_title,
                    subtitle: '${appState.targetFps} FPS',
                    onClick: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => SettingsRadioDialog<int>(
                          title: l.settings_fps_title,
                          options: fpsOptions,
                          selected: appState.targetFps,
                          onConfirm: (value) {
                            appState.updateSetting('target_fps', value);
                            RemoteCamChannel.setTargetFps(value);
                          },
                        ),
                      );
                    },
                  ),
                  SettingsItem(
                    icon: Icons.touch_app,
                    title: l.settings_double_tap_title,
                    subtitle: doubleTapOptions[appState.doubleTapAction],
                    onClick: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => SettingsRadioDialog<int>(
                          title: l.settings_double_tap_title,
                          options: doubleTapOptions,
                          selected: appState.doubleTapAction,
                          onConfirm: (value) =>
                              appState.updateSetting('double_tap_action', value),
                        ),
                      );
                    },
                  ),
                  SettingsItem(
                    icon: Icons.filter_center_focus,
                    title: l.settings_stabilization_title,
                    subtitle: l.settings_stabilization_desc,
                    hasSwitch: true,
                    switchState: appState.stabilizationOff,
                    onSwitchChange: (value) {
                      appState.updateSetting('stabilization_off', value);
                      RemoteCamChannel.setStabilizationOff(value);
                    },
                  ),
                  SettingsItem(
                    icon: Icons.block,
                    title: l.settings_flicker_title,
                    subtitle: flickerOptions[appState.antiFlickerMode],
                    onClick: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => SettingsRadioDialog<int>(
                          title: l.settings_flicker_title,
                          options: flickerOptions,
                          selected: appState.antiFlickerMode,
                          onConfirm: (value) {
                            appState.updateSetting('anti_flicker_mode', value);
                            RemoteCamChannel.setAntiFlickerMode(value);
                          },
                        ),
                      );
                    },
                  ),
                  SettingsItem(
                    icon: Icons.grain,
                    title: l.settings_noise_reduction_title,
                    subtitle: noiseOptions[appState.noiseReductionMode],
                    onClick: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => SettingsRadioDialog<int>(
                          title: l.settings_noise_reduction_title,
                          options: noiseOptions,
                          selected: appState.noiseReductionMode,
                          onConfirm: (value) {
                            appState.updateSetting(
                                'noise_reduction_mode', value);
                            RemoteCamChannel.setNoiseReductionMode(value);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
              SettingsGroup(
                title: l.settings_controls_title,
                children: [
                  SettingsItem(
                    icon: Icons.volume_up,
                    title: l.settings_volume_action_title,
                    subtitle: volumeOptions[appState.volumeAction],
                    onClick: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => SettingsRadioDialog<int>(
                          title: l.settings_volume_action_title,
                          options: volumeOptions,
                          selected: appState.volumeAction,
                          onConfirm: (value) =>
                              appState.updateSetting('volume_action', value),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SettingsGroup(
                title: l.settings_remote_control_title,
                children: [
                  SettingsItem(
                    icon: Icons.movie,
                    title: l.settings_zoom_smoothing_title,
                    subtitle: l.settings_zoom_smoothing_desc,
                    onClick: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => SettingsRadioDialog<int>(
                          title: l.settings_zoom_smoothing_dialog_title,
                          options: zoomSmoothingOptions,
                          selected: appState.zoomSmoothingDelay,
                          onConfirm: (value) {
                            appState.updateSetting(
                                'zoom_smoothing_delay', value);
                            RemoteCamChannel.setZoomSmoothingDelay(value);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class RememberSettingsDialog extends StatefulWidget {
  final AppState appState;
  const RememberSettingsDialog({super.key, required this.appState});

  @override
  State<RememberSettingsDialog> createState() => _RememberSettingsDialogState();
}

class _RememberSettingsDialogState extends State<RememberSettingsDialog> {
  late bool sensor;
  late bool resolution;
  late bool quality;
  late bool h264;
  late bool flash;
  late bool zoom;

  @override
  void initState() {
    super.initState();
    final s = widget.appState;
    sensor = s.rememberSensor;
    resolution = s.rememberResolution;
    quality = s.rememberQuality;
    h264 = s.rememberH264;
    flash = s.rememberFlash;
    zoom = s.rememberZoom;
  }

  Widget _row(String title, bool value, ValueChanged<bool?> onChanged) {
    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      title: Text(title),
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l.settings_remember_dialog_title),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _row(l.settings_remember_sensor, sensor,
                (v) => setState(() => sensor = v ?? false)),
            _row(l.settings_remember_resolution, resolution,
                (v) => setState(() => resolution = v ?? false)),
            _row(l.settings_remember_quality, quality,
                (v) => setState(() => quality = v ?? false)),
            _row(l.settings_remember_h264, h264,
                (v) => setState(() => h264 = v ?? false)),
            _row(l.settings_remember_flash, flash,
                (v) => setState(() => flash = v ?? false)),
            _row(l.settings_remember_zoom, zoom,
                (v) => setState(() => zoom = v ?? false)),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        TextButton(
          onPressed: () {
            widget.appState.updateSetting('remember_sensor', sensor);
            widget.appState.updateSetting('remember_resolution', resolution);
            widget.appState.updateSetting('remember_quality', quality);
            widget.appState.updateSetting('remember_h264', h264);
            widget.appState.updateSetting('remember_flash', flash);
            widget.appState.updateSetting('remember_zoom', zoom);
            Navigator.pop(context);
          },
          child: Text(l.settings_save),
        ),
      ],
    );
  }
}
