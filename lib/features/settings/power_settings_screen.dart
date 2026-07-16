import 'package:flutter/material.dart';
import 'package:remotecam_flutter/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../app.dart';
import '../../core/platform_channel.dart';
import 'widgets/settings_widgets.dart';

class PowerSettingsScreen extends StatelessWidget {
  const PowerSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final appState = RemoteCamApp.of(context).appState;
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final dimOptions = <int, String>{
          0: l.settings_power_auto_dim_off,
          45000: l.settings_power_auto_dim_45s,
          60000: l.settings_power_auto_dim_1m,
          90000: l.settings_power_auto_dim_90s,
          120000: l.settings_power_auto_dim_2m,
          180000: l.settings_power_auto_dim_3m,
          300000: l.settings_power_auto_dim_5m,
        };
        return SettingsScaffold(
          title: l.settings_power_title,
          body: ListView(
            padding: const EdgeInsets.only(bottom: 16),
            children: [
              SettingsGroup(
                title: l.settings_power_title,
                children: [
                  SettingsItem(
                    icon: Icons.battery_charging_full,
                    title: l.settings_power_ignore_optimizations,
                    subtitle: l.settings_power_ignore_optimizations_desc,
                    hasSwitch: true,
                    switchState: false,
                    onSwitchChange: (_) async {
                      await launchUrl(Uri.parse(
                          'android.settings.IGNORE_BATTERY_OPTIMIZATION_SETTINGS'));
                    },
                  ),
                  SettingsItem(
                    icon: Icons.brightness_low,
                    title: l.settings_power_auto_dim,
                    subtitle: dimOptions[appState.autoDimDelay],
                    onClick: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => SettingsRadioDialog<int>(
                          title: l.settings_power_auto_dim_dialog_title,
                          options: dimOptions,
                          selected: appState.autoDimDelay,
                          onConfirm: (value) =>
                              appState.updateSetting('auto_dim_delay', value),
                        ),
                      );
                    },
                  ),
                  SettingsItem(
                    icon: Icons.lock,
                    title: l.settings_power_lock_input,
                    subtitle: l.settings_power_lock_input_desc,
                    hasSwitch: true,
                    switchState: appState.lockInputOnDim,
                    onSwitchChange: (value) =>
                        appState.updateSetting('lock_input_on_dim', value),
                  ),
                ],
              ),
              SettingsGroup(
                title: l.settings_behavior_title,
                children: [
                  SettingsItem(
                    icon: Icons.picture_in_picture,
                    title: l.settings_power_background_streaming,
                    subtitle: l.settings_power_background_streaming_desc,
                    hasSwitch: true,
                    switchState: appState.backgroundStreaming,
                    onSwitchChange: (value) => appState.updateSetting(
                        'background_streaming', value),
                  ),
                  SettingsItem(
                    icon: Icons.sync,
                    title: l.settings_power_allow_reconnects,
                    subtitle: l.settings_power_allow_reconnects_desc,
                    hasSwitch: true,
                    switchState: appState.allowReconnects,
                    onSwitchChange: (value) =>
                        appState.updateSetting('allow_reconnects', value),
                  ),
                ],
              ),
              SettingsGroup(
                title: l.settings_network_title,
                children: [
                  SettingsItem(
                    icon: Icons.settings_ethernet,
                    title: l.settings_port_title,
                    subtitle: '${appState.httpPort}',
                    onClick: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => HttpPortDialog(
                          currentPort: appState.httpPort,
                          onConfirm: (value) {
                            appState.updateSetting('http_port', value);
                            RemoteCamChannel.setHttpPort(value);
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

class HttpPortDialog extends StatefulWidget {
  final int currentPort;
  final ValueChanged<int> onConfirm;
  const HttpPortDialog({
    super.key,
    required this.currentPort,
    required this.onConfirm,
  });

  @override
  State<HttpPortDialog> createState() => _HttpPortDialogState();
}

class _HttpPortDialogState extends State<HttpPortDialog> {
  late final TextEditingController _controller;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentPort.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l.settings_port_dialog_title),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        autofocus: true,
        decoration: InputDecoration(
          labelText: l.settings_port_dialog_label,
          errorText: _error,
        ),
        onChanged: (_) {
          if (_error != null) setState(() => _error = null);
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        TextButton(
          onPressed: () {
            final value = int.tryParse(_controller.text);
            if (value == null || value < 1025 || value > 65535) {
              setState(() => _error = l.settings_port_dialog_invalid);
            } else {
              widget.onConfirm(value);
              Navigator.pop(context);
            }
          },
          child: Text(MaterialLocalizations.of(context).okButtonLabel),
        ),
      ],
    );
  }
}
