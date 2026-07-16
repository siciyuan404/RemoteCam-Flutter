import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:remotecam_flutter/l10n/app_localizations.dart';
import 'core/app_state.dart';
import 'features/permissions/permission_screen.dart';
import 'features/camera/camera_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/settings/camera_settings_screen.dart';
import 'features/settings/power_settings_screen.dart';

class RemoteCamApp extends StatefulWidget {
  const RemoteCamApp({super.key});

  static RemoteCamAppState of(BuildContext context) =>
      context.findAncestorStateOfType<RemoteCamAppState>()!;

  @override
  State<RemoteCamApp> createState() => RemoteCamAppState();
}

class RemoteCamAppState extends State<RemoteCamApp> {
  final AppState appState = AppState();

  @override
  void initState() {
    super.initState();
    appState.loadSettings();
    appState.startListening();
  }

  void refreshTheme() => setState(() {});

  Locale? get currentLocale {
    switch (appState.languageCode) {
      case 'en': return const Locale('en');
      case 'fr': return const Locale('fr');
      case 'hu': return const Locale('hu');
      case 'pt': return const Locale('pt');
      default: return null; // auto
    }
  }

  ThemeMode get currentThemeMode {
    switch (appState.themeMode) {
      case 1: return ThemeMode.light;
      case 2: return ThemeMode.dark;
      default: return ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        return DynamicColorBuilder(
          builder: (lightDynamic, darkDynamic) {
            final useDynamic = appState.monetEnabled && lightDynamic != null && darkDynamic != null;
            final lightScheme = useDynamic
                ? lightDynamic.harmonized()
                : ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4));
            final darkScheme = useDynamic
                ? darkDynamic.harmonized()
                : ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4), brightness: Brightness.dark);

            return MaterialApp(
              title: 'RemoteCam',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: lightScheme,
                useMaterial3: true,
                brightness: Brightness.light,
              ),
              darkTheme: ThemeData(
                colorScheme: darkScheme,
                useMaterial3: true,
                brightness: Brightness.dark,
              ),
              themeMode: currentThemeMode,
              locale: currentLocale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: const MainScreen(),
              routes: {
                '/camera': (context) => const CameraScreen(),
                '/settings': (context) => const SettingsScreen(),
                '/camera_settings': (context) => const CameraSettingsScreen(),
                '/power_settings': (context) => const PowerSettingsScreen(),
              },
            );
          },
        );
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PermissionScreen();
  }
}
