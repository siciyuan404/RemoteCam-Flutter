import 'package:flutter/material.dart';
import 'package:remotecam_flutter/l10n/app_localizations.dart';
import '../../app.dart';
import 'about_dialog.dart';
import 'widgets/settings_widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final appState = RemoteCamApp.of(context).appState;
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final themeOptions = <int, String>{
          0: l.settings_theme_auto,
          1: l.settings_theme_light,
          2: l.settings_theme_dark,
        };
        final languageOptions = <String, String>{
          'auto': l.settings_lang_auto,
          'en': l.settings_lang_en,
          'fr': l.settings_lang_fr,
          'hu': l.settings_lang_hu,
          'pt': l.settings_lang_pt_br,
        };
        return SettingsScaffold(
          title: l.settings_title,
          body: ListView(
            padding: const EdgeInsets.only(bottom: 16),
            children: [
              SettingsGroup(
                title: l.settings_appearance,
                children: [
                  SettingsItem(
                    icon: Icons.dark_mode,
                    title: l.settings_theme,
                    subtitle: themeOptions[appState.themeMode],
                    onClick: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => SettingsRadioDialog<int>(
                          title: l.settings_theme,
                          options: themeOptions,
                          selected: appState.themeMode,
                          onConfirm: (value) {
                            appState.updateSetting('theme_mode', value);
                            RemoteCamApp.of(context).refreshTheme();
                          },
                        ),
                      );
                    },
                  ),
                  SettingsItem(
                    icon: Icons.palette,
                    title: l.settings_monet,
                    hasSwitch: true,
                    switchState: appState.monetEnabled,
                    onSwitchChange: (value) {
                      appState.updateSetting('monet_enabled', value);
                      RemoteCamApp.of(context).refreshTheme();
                    },
                  ),
                ],
              ),
              SettingsGroup(
                title: l.settings_behavior_title,
                children: [
                  SettingsItem(
                    icon: Icons.visibility,
                    title: l.settings_keep_screen_on,
                    hasSwitch: true,
                    switchState: appState.keepScreenOn,
                    onSwitchChange: (value) =>
                        appState.updateSetting('keep_screen_on', value),
                  ),
                  SettingsItem(
                    icon: Icons.language,
                    title: l.settings_language,
                    subtitle: languageOptions[appState.languageCode],
                    onClick: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => SettingsRadioDialog<String>(
                          title: l.settings_language,
                          options: languageOptions,
                          selected: appState.languageCode,
                          onConfirm: (value) {
                            appState.updateSetting('language_code', value);
                            RemoteCamApp.of(context).refreshTheme();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
              SettingsGroup(
                title: l.settings_additional_title,
                children: [
                  SettingsItem(
                    icon: Icons.camera_alt,
                    title: l.settings_camera_title,
                    onClick: () =>
                        Navigator.pushNamed(context, '/camera_settings'),
                  ),
                  SettingsItem(
                    icon: Icons.power_settings_new,
                    title: l.settings_power_title,
                    onClick: () =>
                        Navigator.pushNamed(context, '/power_settings'),
                  ),
                ],
              ),
              SettingsGroup(
                title: l.settings_app_title,
                children: [
                  SettingsItem(
                    icon: Icons.info,
                    title: l.settings_about_app,
                    onClick: () => showDialog(
                      context: context,
                      builder: (ctx) => const RemoteCamAboutDialog(),
                    ),
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
