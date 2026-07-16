// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'RemoteCam';

  @override
  String get notif_title => 'RemoteCam (active)';

  @override
  String get notif_text => 'Tap to open';

  @override
  String get notif_kill => 'Kill';

  @override
  String get perm_welcome => 'Welcome to RemoteCam';

  @override
  String get perm_welcome_title => 'Authorization Required';

  @override
  String get perm_desc =>
      'To work, the app needs access to your camera and to show notifications.';

  @override
  String get perm_reasons_title => 'Why these permissions?';

  @override
  String get perm_cam_reason => 'To capture and stream video.';

  @override
  String get perm_notif_reason =>
      'To keep the service active in the background.';

  @override
  String get perm_button => 'Grant permissions';

  @override
  String get perm_toast_denied =>
      'All permissions are required to use the application.';

  @override
  String get cam_settings => 'Settings';

  @override
  String get cam_stop => 'STOP';

  @override
  String get cam_clipboard_copied => 'Copied to clipboard';

  @override
  String get cam_controls => 'Controls';

  @override
  String get cam_local_preview => 'Local preview';

  @override
  String get cam_mjpeg_stream => 'MJPEG Stream';

  @override
  String get cam_flash => 'Flashlight';

  @override
  String get cam_flash_level => 'Brightness';

  @override
  String get cam_parameters => 'Parameters';

  @override
  String get cam_sensor => 'Sensor';

  @override
  String get cam_resolution => 'Resolution';

  @override
  String get cam_quality => 'JPEG Quality';

  @override
  String get cam_information => 'Information';

  @override
  String get cam_overlay_locked => 'Screen dimmed and locked. Tap to unlock.';

  @override
  String get settings_title => 'Settings';

  @override
  String get settings_back => 'Back';

  @override
  String get settings_close => 'Close';

  @override
  String get settings_save => 'Save';

  @override
  String get settings_appearance => 'Appearance';

  @override
  String get settings_theme => 'Theme';

  @override
  String get settings_theme_auto => 'Automatic (System)';

  @override
  String get settings_theme_light => 'Light';

  @override
  String get settings_theme_dark => 'Dark';

  @override
  String get settings_monet => 'Dynamic Color (Monet)';

  @override
  String get settings_language => 'Language';

  @override
  String get settings_lang_auto => 'Automatic (System)';

  @override
  String get settings_lang_en => 'English';

  @override
  String get settings_lang_fr => 'Français (French)';

  @override
  String get settings_lang_hu => 'Magyar (Hungarian)';

  @override
  String get settings_lang_pt_br => 'Português (Portuguese)';

  @override
  String get settings_behavior_title => 'Behavior';

  @override
  String get settings_keep_screen_on => 'Keep screen on';

  @override
  String get settings_camera_title => 'Camera';

  @override
  String get settings_remember_title => 'Remember camera settings';

  @override
  String get settings_remember_desc => 'Applies saved settings on startup';

  @override
  String get settings_remember_dialog_title => 'Remember...';

  @override
  String get settings_remember_sensor => 'Camera Sensor';

  @override
  String get settings_remember_resolution => 'Resolution';

  @override
  String get settings_remember_quality => 'JPEG Quality';

  @override
  String get settings_remember_flash => 'Flash state';

  @override
  String get settings_remember_zoom => 'Zoom level';

  @override
  String get settings_remember_h264 => 'H.264 Settings';

  @override
  String get settings_fps_title => 'Target FPS';

  @override
  String get settings_stabilization_title => 'Disable Stabilization (OIS/EIS)';

  @override
  String get settings_stabilization_desc => 'Improves latency on a tripod';

  @override
  String get settings_flicker_title => 'Anti-Flicker';

  @override
  String get settings_flicker_auto => 'Auto';

  @override
  String get settings_flicker_off => 'Off';

  @override
  String get settings_flicker_50hz => '50Hz (Europe, Asia)';

  @override
  String get settings_flicker_60hz => '60Hz (North America)';

  @override
  String get settings_noise_reduction_title => 'Noise Reduction';

  @override
  String get settings_noise_reduction_auto => 'Auto';

  @override
  String get settings_noise_reduction_off => 'Off';

  @override
  String get settings_noise_reduction_low => 'Low (Fast)';

  @override
  String get settings_noise_reduction_high => 'High (High Quality)';

  @override
  String get settings_format_title => 'Stream Format';

  @override
  String get settings_format_desc => 'Format used for the HTTP stream';

  @override
  String get settings_format_mjpeg => 'MJPEG';

  @override
  String get settings_format_mjpeg_desc => 'Images';

  @override
  String get settings_format_h264 => 'H.264';

  @override
  String get settings_format_h264_desc => 'Video - Smooth';

  @override
  String get settings_controls_title => 'Controls';

  @override
  String get settings_double_tap_title => 'Double-tap action';

  @override
  String get settings_double_tap_off => 'Off';

  @override
  String get settings_double_tap_switch_cam => 'Switch camera';

  @override
  String get settings_double_tap_toggle_zoom => 'Toggle 2x zoom';

  @override
  String get settings_volume_action_title => 'Volume key action';

  @override
  String get settings_volume_action_off => 'Do nothing';

  @override
  String get settings_volume_action_zoom => 'Control zoom';

  @override
  String get settings_volume_action_switch_cam => 'Switch camera';

  @override
  String get settings_volume_action_toggle_flash => 'Toggle flashlight';

  @override
  String get settings_remote_control_title => 'Remote Control';

  @override
  String get settings_zoom_smoothing_title => 'Zoom Smoothing';

  @override
  String get settings_zoom_smoothing_desc =>
      'Smooths out zoom changes from volume keys and double-tap';

  @override
  String get settings_zoom_smoothing_dialog_title => 'Smoothing Delay';

  @override
  String get settings_zoom_smoothing_none => 'None (Instant)';

  @override
  String get settings_power_title => 'Power and Screen';

  @override
  String get settings_power_ignore_optimizations =>
      'Ignore battery optimizations';

  @override
  String get settings_power_ignore_optimizations_desc =>
      'Bypass power-saving features (opens system settings)';

  @override
  String get settings_power_auto_dim => 'Auto dim screen';

  @override
  String get settings_power_auto_dim_dialog_title => 'Dim screen after...';

  @override
  String get settings_power_auto_dim_off => 'Off';

  @override
  String get settings_power_auto_dim_45s => '45 seconds';

  @override
  String get settings_power_auto_dim_1m => '1 minute';

  @override
  String get settings_power_auto_dim_90s => '90 seconds';

  @override
  String get settings_power_auto_dim_2m => '2 minutes';

  @override
  String get settings_power_auto_dim_3m => '3 minutes';

  @override
  String get settings_power_auto_dim_5m => '5 minutes';

  @override
  String get settings_power_lock_input => 'Lock input when dimmed';

  @override
  String get settings_power_lock_input_desc => 'Prevents accidental input';

  @override
  String get settings_power_background_streaming => 'Background streaming';

  @override
  String get settings_power_background_streaming_desc =>
      'Keep service active when app is in background';

  @override
  String get settings_power_allow_reconnects => 'Allow reconnects';

  @override
  String get settings_power_allow_reconnects_desc =>
      'Allows clients to reconnect to the stream';

  @override
  String get settings_network_title => 'Network';

  @override
  String get settings_port_title => 'HTTP Port';

  @override
  String get settings_port_summary => 'Port used by the MJPEG stream.';

  @override
  String get settings_port_dialog_title => 'Set HTTP Port';

  @override
  String get settings_port_dialog_label => 'Port (1025-65535)';

  @override
  String get settings_port_dialog_invalid =>
      'Invalid port. Must be between 1025 and 65535.';

  @override
  String get settings_app_title => 'Application';

  @override
  String get settings_additional_title => 'Additional Settings';

  @override
  String get settings_about_app => 'Application';

  @override
  String get settings_about_title => 'About RemoteCam';

  @override
  String get about_fork =>
      'This application is an improved fork, maintained by @alananassss.';

  @override
  String get about_star => 'Star the repo on GitHub';

  @override
  String get about_telegram =>
      'Feel free to contact me on Telegram for any suggestions: @alananassss';

  @override
  String about_version(String version) {
    return 'Version $version';
  }

  @override
  String get egg_title_alan => 'A little note from the dev :p';

  @override
  String get egg_message_alan =>
      'Hey there! Alan here ^^\n\nFunny that you clicked 7 times to get here!\n\nJust wanted to say thanks. This app is a \'fork\', which means I took the awesome base from the original dev and spent a ton of time adding my own improvements (days and days, evenings and weekends...).\n\nI really hope you find it useful!\n\nThanks for using it!\n- Alan';

  @override
  String get egg_button_alan => 'Cool! Greetings!';

  @override
  String get h264_bitrate => 'Bitrate (Mbps)';

  @override
  String get h264_mode => 'Bitrate Mode';

  @override
  String get h264_mode_cbr => 'Constant (CBR - Low Latency)';

  @override
  String get h264_mode_vbr => 'Variable (VBR - Quality)';

  @override
  String get error_port_title => 'Port unavailable';

  @override
  String error_port_message(int port) {
    return 'Port $port is already in use by another application. Please choose a different one.';
  }

  @override
  String get btn_change_port => 'Change Port';
}
