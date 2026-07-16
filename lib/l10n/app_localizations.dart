import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hu.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
    Locale('hu'),
    Locale('pt'),
  ];

  /// Application name
  ///
  /// In en, this message translates to:
  /// **'RemoteCam'**
  String get app_name;

  /// Notification title when service is active
  ///
  /// In en, this message translates to:
  /// **'RemoteCam (active)'**
  String get notif_title;

  /// Notification text
  ///
  /// In en, this message translates to:
  /// **'Tap to open'**
  String get notif_text;

  /// Notification action to kill the service
  ///
  /// In en, this message translates to:
  /// **'Kill'**
  String get notif_kill;

  /// Welcome message on permissions screen
  ///
  /// In en, this message translates to:
  /// **'Welcome to RemoteCam'**
  String get perm_welcome;

  /// Title for permissions screen
  ///
  /// In en, this message translates to:
  /// **'Authorization Required'**
  String get perm_welcome_title;

  /// Description of why permissions are needed
  ///
  /// In en, this message translates to:
  /// **'To work, the app needs access to your camera and to show notifications.'**
  String get perm_desc;

  /// Title for the permissions reasons section
  ///
  /// In en, this message translates to:
  /// **'Why these permissions?'**
  String get perm_reasons_title;

  /// Reason for camera permission
  ///
  /// In en, this message translates to:
  /// **'To capture and stream video.'**
  String get perm_cam_reason;

  /// Reason for notification permission
  ///
  /// In en, this message translates to:
  /// **'To keep the service active in the background.'**
  String get perm_notif_reason;

  /// Button to grant permissions
  ///
  /// In en, this message translates to:
  /// **'Grant permissions'**
  String get perm_button;

  /// Toast shown when permissions are denied
  ///
  /// In en, this message translates to:
  /// **'All permissions are required to use the application.'**
  String get perm_toast_denied;

  /// Camera screen settings button
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get cam_settings;

  /// Stop button text
  ///
  /// In en, this message translates to:
  /// **'STOP'**
  String get cam_stop;

  /// Toast when URL is copied to clipboard
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get cam_clipboard_copied;

  /// Camera controls section title
  ///
  /// In en, this message translates to:
  /// **'Controls'**
  String get cam_controls;

  /// Local preview toggle
  ///
  /// In en, this message translates to:
  /// **'Local preview'**
  String get cam_local_preview;

  /// MJPEG stream URL section
  ///
  /// In en, this message translates to:
  /// **'MJPEG Stream'**
  String get cam_mjpeg_stream;

  /// Flashlight toggle
  ///
  /// In en, this message translates to:
  /// **'Flashlight'**
  String get cam_flash;

  /// Flashlight brightness level
  ///
  /// In en, this message translates to:
  /// **'Brightness'**
  String get cam_flash_level;

  /// Camera parameters section title
  ///
  /// In en, this message translates to:
  /// **'Parameters'**
  String get cam_parameters;

  /// Camera sensor selection
  ///
  /// In en, this message translates to:
  /// **'Sensor'**
  String get cam_sensor;

  /// Camera resolution selection
  ///
  /// In en, this message translates to:
  /// **'Resolution'**
  String get cam_resolution;

  /// JPEG quality setting
  ///
  /// In en, this message translates to:
  /// **'JPEG Quality'**
  String get cam_quality;

  /// Camera information section title
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get cam_information;

  /// Overlay text when screen is locked
  ///
  /// In en, this message translates to:
  /// **'Screen dimmed and locked. Tap to unlock.'**
  String get cam_overlay_locked;

  /// Settings screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// Back button
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get settings_back;

  /// Close button
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get settings_close;

  /// Save button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get settings_save;

  /// Appearance settings section
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settings_appearance;

  /// Theme setting
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settings_theme;

  /// Automatic theme option
  ///
  /// In en, this message translates to:
  /// **'Automatic (System)'**
  String get settings_theme_auto;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settings_theme_light;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settings_theme_dark;

  /// Dynamic color (Monet) toggle
  ///
  /// In en, this message translates to:
  /// **'Dynamic Color (Monet)'**
  String get settings_monet;

  /// Language setting
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_language;

  /// Automatic language option
  ///
  /// In en, this message translates to:
  /// **'Automatic (System)'**
  String get settings_lang_auto;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settings_lang_en;

  /// French language option
  ///
  /// In en, this message translates to:
  /// **'Français (French)'**
  String get settings_lang_fr;

  /// Hungarian language option
  ///
  /// In en, this message translates to:
  /// **'Magyar (Hungarian)'**
  String get settings_lang_hu;

  /// Portuguese language option
  ///
  /// In en, this message translates to:
  /// **'Português (Portuguese)'**
  String get settings_lang_pt_br;

  /// Behavior settings section
  ///
  /// In en, this message translates to:
  /// **'Behavior'**
  String get settings_behavior_title;

  /// Keep screen on toggle
  ///
  /// In en, this message translates to:
  /// **'Keep screen on'**
  String get settings_keep_screen_on;

  /// Camera settings section
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get settings_camera_title;

  /// Remember camera settings toggle
  ///
  /// In en, this message translates to:
  /// **'Remember camera settings'**
  String get settings_remember_title;

  /// Description for remember settings
  ///
  /// In en, this message translates to:
  /// **'Applies saved settings on startup'**
  String get settings_remember_desc;

  /// Dialog title for remember settings
  ///
  /// In en, this message translates to:
  /// **'Remember...'**
  String get settings_remember_dialog_title;

  /// Remember sensor option
  ///
  /// In en, this message translates to:
  /// **'Camera Sensor'**
  String get settings_remember_sensor;

  /// Remember resolution option
  ///
  /// In en, this message translates to:
  /// **'Resolution'**
  String get settings_remember_resolution;

  /// Remember JPEG quality option
  ///
  /// In en, this message translates to:
  /// **'JPEG Quality'**
  String get settings_remember_quality;

  /// Remember flash state option
  ///
  /// In en, this message translates to:
  /// **'Flash state'**
  String get settings_remember_flash;

  /// Remember zoom level option
  ///
  /// In en, this message translates to:
  /// **'Zoom level'**
  String get settings_remember_zoom;

  /// Remember H.264 settings option
  ///
  /// In en, this message translates to:
  /// **'H.264 Settings'**
  String get settings_remember_h264;

  /// Target FPS setting
  ///
  /// In en, this message translates to:
  /// **'Target FPS'**
  String get settings_fps_title;

  /// Disable stabilization toggle
  ///
  /// In en, this message translates to:
  /// **'Disable Stabilization (OIS/EIS)'**
  String get settings_stabilization_title;

  /// Description for stabilization
  ///
  /// In en, this message translates to:
  /// **'Improves latency on a tripod'**
  String get settings_stabilization_desc;

  /// Anti-flicker setting
  ///
  /// In en, this message translates to:
  /// **'Anti-Flicker'**
  String get settings_flicker_title;

  /// Auto anti-flicker option
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get settings_flicker_auto;

  /// Off anti-flicker option
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get settings_flicker_off;

  /// 50Hz anti-flicker option
  ///
  /// In en, this message translates to:
  /// **'50Hz (Europe, Asia)'**
  String get settings_flicker_50hz;

  /// 60Hz anti-flicker option
  ///
  /// In en, this message translates to:
  /// **'60Hz (North America)'**
  String get settings_flicker_60hz;

  /// Noise reduction setting
  ///
  /// In en, this message translates to:
  /// **'Noise Reduction'**
  String get settings_noise_reduction_title;

  /// Auto noise reduction option
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get settings_noise_reduction_auto;

  /// Off noise reduction option
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get settings_noise_reduction_off;

  /// Low noise reduction option
  ///
  /// In en, this message translates to:
  /// **'Low (Fast)'**
  String get settings_noise_reduction_low;

  /// High noise reduction option
  ///
  /// In en, this message translates to:
  /// **'High (High Quality)'**
  String get settings_noise_reduction_high;

  /// Stream format setting
  ///
  /// In en, this message translates to:
  /// **'Stream Format'**
  String get settings_format_title;

  /// Description for stream format
  ///
  /// In en, this message translates to:
  /// **'Format used for the HTTP stream'**
  String get settings_format_desc;

  /// MJPEG format option
  ///
  /// In en, this message translates to:
  /// **'MJPEG'**
  String get settings_format_mjpeg;

  /// MJPEG format description
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get settings_format_mjpeg_desc;

  /// H.264 format option
  ///
  /// In en, this message translates to:
  /// **'H.264'**
  String get settings_format_h264;

  /// H.264 format description
  ///
  /// In en, this message translates to:
  /// **'Video - Smooth'**
  String get settings_format_h264_desc;

  /// Controls settings section
  ///
  /// In en, this message translates to:
  /// **'Controls'**
  String get settings_controls_title;

  /// Double-tap action setting
  ///
  /// In en, this message translates to:
  /// **'Double-tap action'**
  String get settings_double_tap_title;

  /// Off double-tap option
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get settings_double_tap_off;

  /// Switch camera double-tap option
  ///
  /// In en, this message translates to:
  /// **'Switch camera'**
  String get settings_double_tap_switch_cam;

  /// Toggle zoom double-tap option
  ///
  /// In en, this message translates to:
  /// **'Toggle 2x zoom'**
  String get settings_double_tap_toggle_zoom;

  /// Volume key action setting
  ///
  /// In en, this message translates to:
  /// **'Volume key action'**
  String get settings_volume_action_title;

  /// Off volume action option
  ///
  /// In en, this message translates to:
  /// **'Do nothing'**
  String get settings_volume_action_off;

  /// Zoom volume action option
  ///
  /// In en, this message translates to:
  /// **'Control zoom'**
  String get settings_volume_action_zoom;

  /// Switch camera volume action option
  ///
  /// In en, this message translates to:
  /// **'Switch camera'**
  String get settings_volume_action_switch_cam;

  /// Toggle flash volume action option
  ///
  /// In en, this message translates to:
  /// **'Toggle flashlight'**
  String get settings_volume_action_toggle_flash;

  /// Remote control settings section
  ///
  /// In en, this message translates to:
  /// **'Remote Control'**
  String get settings_remote_control_title;

  /// Zoom smoothing setting
  ///
  /// In en, this message translates to:
  /// **'Zoom Smoothing'**
  String get settings_zoom_smoothing_title;

  /// Description for zoom smoothing
  ///
  /// In en, this message translates to:
  /// **'Smooths out zoom changes from volume keys and double-tap'**
  String get settings_zoom_smoothing_desc;

  /// Dialog title for zoom smoothing
  ///
  /// In en, this message translates to:
  /// **'Smoothing Delay'**
  String get settings_zoom_smoothing_dialog_title;

  /// None zoom smoothing option
  ///
  /// In en, this message translates to:
  /// **'None (Instant)'**
  String get settings_zoom_smoothing_none;

  /// Power and screen settings section
  ///
  /// In en, this message translates to:
  /// **'Power and Screen'**
  String get settings_power_title;

  /// Ignore battery optimizations toggle
  ///
  /// In en, this message translates to:
  /// **'Ignore battery optimizations'**
  String get settings_power_ignore_optimizations;

  /// Description for ignore optimizations
  ///
  /// In en, this message translates to:
  /// **'Bypass power-saving features (opens system settings)'**
  String get settings_power_ignore_optimizations_desc;

  /// Auto dim screen toggle
  ///
  /// In en, this message translates to:
  /// **'Auto dim screen'**
  String get settings_power_auto_dim;

  /// Dialog title for auto dim
  ///
  /// In en, this message translates to:
  /// **'Dim screen after...'**
  String get settings_power_auto_dim_dialog_title;

  /// Off auto dim option
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get settings_power_auto_dim_off;

  /// 45 seconds auto dim option
  ///
  /// In en, this message translates to:
  /// **'45 seconds'**
  String get settings_power_auto_dim_45s;

  /// 1 minute auto dim option
  ///
  /// In en, this message translates to:
  /// **'1 minute'**
  String get settings_power_auto_dim_1m;

  /// 90 seconds auto dim option
  ///
  /// In en, this message translates to:
  /// **'90 seconds'**
  String get settings_power_auto_dim_90s;

  /// 2 minutes auto dim option
  ///
  /// In en, this message translates to:
  /// **'2 minutes'**
  String get settings_power_auto_dim_2m;

  /// 3 minutes auto dim option
  ///
  /// In en, this message translates to:
  /// **'3 minutes'**
  String get settings_power_auto_dim_3m;

  /// 5 minutes auto dim option
  ///
  /// In en, this message translates to:
  /// **'5 minutes'**
  String get settings_power_auto_dim_5m;

  /// Lock input when dimmed toggle
  ///
  /// In en, this message translates to:
  /// **'Lock input when dimmed'**
  String get settings_power_lock_input;

  /// Description for lock input
  ///
  /// In en, this message translates to:
  /// **'Prevents accidental input'**
  String get settings_power_lock_input_desc;

  /// Background streaming toggle
  ///
  /// In en, this message translates to:
  /// **'Background streaming'**
  String get settings_power_background_streaming;

  /// Description for background streaming
  ///
  /// In en, this message translates to:
  /// **'Keep service active when app is in background'**
  String get settings_power_background_streaming_desc;

  /// Allow reconnects toggle
  ///
  /// In en, this message translates to:
  /// **'Allow reconnects'**
  String get settings_power_allow_reconnects;

  /// Description for allow reconnects
  ///
  /// In en, this message translates to:
  /// **'Allows clients to reconnect to the stream'**
  String get settings_power_allow_reconnects_desc;

  /// Network settings section
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get settings_network_title;

  /// HTTP port setting
  ///
  /// In en, this message translates to:
  /// **'HTTP Port'**
  String get settings_port_title;

  /// Summary for HTTP port
  ///
  /// In en, this message translates to:
  /// **'Port used by the MJPEG stream.'**
  String get settings_port_summary;

  /// Dialog title for HTTP port
  ///
  /// In en, this message translates to:
  /// **'Set HTTP Port'**
  String get settings_port_dialog_title;

  /// Label for HTTP port dialog
  ///
  /// In en, this message translates to:
  /// **'Port (1025-65535)'**
  String get settings_port_dialog_label;

  /// Invalid port message
  ///
  /// In en, this message translates to:
  /// **'Invalid port. Must be between 1025 and 65535.'**
  String get settings_port_dialog_invalid;

  /// Application settings section
  ///
  /// In en, this message translates to:
  /// **'Application'**
  String get settings_app_title;

  /// Additional settings section
  ///
  /// In en, this message translates to:
  /// **'Additional Settings'**
  String get settings_additional_title;

  /// About application option
  ///
  /// In en, this message translates to:
  /// **'Application'**
  String get settings_about_app;

  /// About dialog title
  ///
  /// In en, this message translates to:
  /// **'About RemoteCam'**
  String get settings_about_title;

  /// Fork information text
  ///
  /// In en, this message translates to:
  /// **'This application is an improved fork, maintained by @alananassss.'**
  String get about_fork;

  /// Star on GitHub action
  ///
  /// In en, this message translates to:
  /// **'Star the repo on GitHub'**
  String get about_star;

  /// Telegram contact text
  ///
  /// In en, this message translates to:
  /// **'Feel free to contact me on Telegram for any suggestions: @alananassss'**
  String get about_telegram;

  /// Version text
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String about_version(String version);

  /// Easter egg title
  ///
  /// In en, this message translates to:
  /// **'A little note from the dev :p'**
  String get egg_title_alan;

  /// Easter egg message from developer
  ///
  /// In en, this message translates to:
  /// **'Hey there! Alan here ^^\n\nFunny that you clicked 7 times to get here!\n\nJust wanted to say thanks. This app is a \'fork\', which means I took the awesome base from the original dev and spent a ton of time adding my own improvements (days and days, evenings and weekends...).\n\nI really hope you find it useful!\n\nThanks for using it!\n- Alan'**
  String get egg_message_alan;

  /// Easter egg button
  ///
  /// In en, this message translates to:
  /// **'Cool! Greetings!'**
  String get egg_button_alan;

  /// H.264 bitrate setting
  ///
  /// In en, this message translates to:
  /// **'Bitrate (Mbps)'**
  String get h264_bitrate;

  /// H.264 bitrate mode setting
  ///
  /// In en, this message translates to:
  /// **'Bitrate Mode'**
  String get h264_mode;

  /// Constant bitrate mode option
  ///
  /// In en, this message translates to:
  /// **'Constant (CBR - Low Latency)'**
  String get h264_mode_cbr;

  /// Variable bitrate mode option
  ///
  /// In en, this message translates to:
  /// **'Variable (VBR - Quality)'**
  String get h264_mode_vbr;

  /// Port error title
  ///
  /// In en, this message translates to:
  /// **'Port unavailable'**
  String get error_port_title;

  /// Port error message
  ///
  /// In en, this message translates to:
  /// **'Port {port} is already in use by another application. Please choose a different one.'**
  String error_port_message(int port);

  /// Change port button
  ///
  /// In en, this message translates to:
  /// **'Change Port'**
  String get btn_change_port;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr', 'hu', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'hu':
      return AppLocalizationsHu();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
