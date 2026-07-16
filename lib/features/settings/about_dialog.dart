import 'package:flutter/material.dart';
import 'package:remotecam_flutter/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class RemoteCamAboutDialog extends StatefulWidget {
  const RemoteCamAboutDialog({super.key});

  @override
  State<RemoteCamAboutDialog> createState() => _RemoteCamAboutDialogState();
}

class _RemoteCamAboutDialogState extends State<RemoteCamAboutDialog> {
  int _tapCount = 0;
  static const _version = '1.2.0';
  static const _repoUrl = 'https://github.com/alan7383/RemoteCam-Enhanced';

  void _onVersionTap() {
    setState(() => _tapCount++);
    if (_tapCount >= 7) {
      _tapCount = 0;
      final messenger = ScaffoldMessenger.of(context);
      Navigator.of(context).pop();
      messenger.showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.egg_title_alan)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l.settings_about_title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.about_fork),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              icon: const Icon(Icons.star),
              label: Text(l.about_star),
              onPressed: () => launchUrl(Uri.parse(_repoUrl)),
            ),
          ),
          const SizedBox(height: 8),
          Text(l.about_telegram),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: _onVersionTap,
            child: Text(
              l.about_version(_version),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l.settings_close),
        ),
      ],
    );
  }
}
