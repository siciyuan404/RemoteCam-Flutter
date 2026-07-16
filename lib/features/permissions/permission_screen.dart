import 'package:flutter/material.dart';
import 'package:remotecam_flutter/l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import '../camera/camera_screen.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  @override
  void initState() {
    super.initState();
    _checkPermissionsAndNavigate();
  }

  Future<void> _checkPermissionsAndNavigate() async {
    final camera = await Permission.camera.status;
    final notif = await Permission.notification.status;
    if (camera.isGranted && notif.isGranted && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CameraScreen()),
      );
    }
  }

  Future<void> _requestPermissions() async {
    final statuses = await [
      Permission.camera,
      Permission.notification,
    ].request();

    final allGranted = statuses.values.every((s) => s.isGranted);
    if (!mounted) return;

    if (allGranted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CameraScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.perm_toast_denied)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.perm_welcome_title),
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
      ),
      bottomNavigationBar: BottomAppBar(
        color: cs.surfaceContainer,
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: FilledButton(
            onPressed: _requestPermissions,
            child: Text(l.perm_button),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              Container(
                width: 120, height: 120,
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.camera_rounded, size: 72, color: cs.onPrimaryContainer),
              ),
              const SizedBox(height: 24),
              Text(l.perm_welcome, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              Text(
                l.perm_desc,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
              ),
              const SizedBox(height: 32),
              Card(
                color: cs.surfaceContainerLowest,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.perm_reasons_title, style: Theme.of(context).textTheme.titleMedium),
                      const Divider(),
                      _PermissionRow(icon: Icons.camera_alt, text: l.perm_cam_reason, color: cs.primary),
                      const SizedBox(height: 12),
                      _PermissionRow(icon: Icons.notifications, text: l.perm_notif_reason, color: cs.primary),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PermissionRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _PermissionRow({required this.icon, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, size: 32, color: color),
      const SizedBox(width: 16),
      Expanded(child: Text(text)),
    ]);
  }
}
