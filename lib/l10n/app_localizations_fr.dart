// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get app_name => 'RemoteCam';

  @override
  String get notif_title => 'RemoteCam (actif)';

  @override
  String get notif_text => 'Appuyer pour ouvrir';

  @override
  String get notif_kill => 'Arrêter';

  @override
  String get perm_welcome => 'Bienvenue sur RemoteCam';

  @override
  String get perm_welcome_title => 'Autorisation requise';

  @override
  String get perm_desc =>
      'Pour fonctionner, l\'application a besoin d\'accéder à votre caméra et d\'afficher des notifications.';

  @override
  String get perm_reasons_title => 'Pourquoi ces autorisations ?';

  @override
  String get perm_cam_reason => 'Pour capturer et diffuser la vidéo.';

  @override
  String get perm_notif_reason =>
      'Pour maintenir le service actif en arrière-plan.';

  @override
  String get perm_button => 'Accorder les autorisations';

  @override
  String get perm_toast_denied =>
      'Toutes les autorisations sont requises pour utiliser l\'application.';

  @override
  String get cam_settings => 'Paramètres';

  @override
  String get cam_stop => 'STOP';

  @override
  String get cam_clipboard_copied => 'Copié dans le presse-papiers';

  @override
  String get cam_controls => 'Contrôles';

  @override
  String get cam_local_preview => 'Aperçu local';

  @override
  String get cam_mjpeg_stream => 'Flux MJPEG';

  @override
  String get cam_flash => 'Lampe torche';

  @override
  String get cam_flash_level => 'Intensité';

  @override
  String get cam_parameters => 'Paramètres';

  @override
  String get cam_sensor => 'Capteur';

  @override
  String get cam_resolution => 'Résolution';

  @override
  String get cam_quality => 'Qualité JPEG';

  @override
  String get cam_information => 'Informations';

  @override
  String get cam_overlay_locked =>
      'Écran assombri et verrouillé. Appuyez pour déverrouiller.';

  @override
  String get settings_title => 'Paramètres';

  @override
  String get settings_back => 'Retour';

  @override
  String get settings_close => 'Fermer';

  @override
  String get settings_save => 'Enregistrer';

  @override
  String get settings_appearance => 'Apparence';

  @override
  String get settings_theme => 'Thème';

  @override
  String get settings_theme_auto => 'Automatique (Système)';

  @override
  String get settings_theme_light => 'Clair';

  @override
  String get settings_theme_dark => 'Sombre';

  @override
  String get settings_monet => 'Couleur dynamique (Monet)';

  @override
  String get settings_language => 'Langue';

  @override
  String get settings_lang_auto => 'Automatique (Système)';

  @override
  String get settings_lang_en => 'English (Anglais)';

  @override
  String get settings_lang_fr => 'Français';

  @override
  String get settings_lang_hu => 'Magyar (Hongrois)';

  @override
  String get settings_lang_pt_br => 'Português (Portugais)';

  @override
  String get settings_behavior_title => 'Comportement';

  @override
  String get settings_keep_screen_on => 'Garder l\'écran allumé';

  @override
  String get settings_camera_title => 'Caméra';

  @override
  String get settings_remember_title => 'Mémoriser les paramètres';

  @override
  String get settings_remember_desc =>
      'Applique les paramètres enregistrés au démarrage';

  @override
  String get settings_remember_dialog_title => 'Mémoriser...';

  @override
  String get settings_remember_sensor => 'Capteur de la caméra';

  @override
  String get settings_remember_resolution => 'Résolution';

  @override
  String get settings_remember_quality => 'Qualité JPEG';

  @override
  String get settings_remember_flash => 'État de la lampe torche';

  @override
  String get settings_remember_zoom => 'Niveau de zoom';

  @override
  String get settings_remember_h264 => 'Paramètres H.264';

  @override
  String get settings_fps_title => 'IPS Cible';

  @override
  String get settings_stabilization_title =>
      'Désactiver la stabilisation (OIS/EIS)';

  @override
  String get settings_stabilization_desc => 'Améliore la latence sur trépied';

  @override
  String get settings_flicker_title => 'Anti-scintillement';

  @override
  String get settings_flicker_auto => 'Auto';

  @override
  String get settings_flicker_off => 'Désactivé';

  @override
  String get settings_flicker_50hz => '50Hz (Europe, Asie)';

  @override
  String get settings_flicker_60hz => '60Hz (Amérique du Nord)';

  @override
  String get settings_noise_reduction_title => 'Réduction du bruit';

  @override
  String get settings_noise_reduction_auto => 'Auto';

  @override
  String get settings_noise_reduction_off => 'Désactivé';

  @override
  String get settings_noise_reduction_low => 'Faible (Rapide)';

  @override
  String get settings_noise_reduction_high => 'Élevée (Haute Qualité)';

  @override
  String get settings_format_title => 'Format du flux';

  @override
  String get settings_format_desc => 'Format utilisé pour le flux HTTP';

  @override
  String get settings_format_mjpeg => 'MJPEG';

  @override
  String get settings_format_mjpeg_desc => 'Images';

  @override
  String get settings_format_h264 => 'H.264';

  @override
  String get settings_format_h264_desc => 'Vidéo - Fluide';

  @override
  String get settings_controls_title => 'Contrôles';

  @override
  String get settings_double_tap_title => 'Action du double-appui';

  @override
  String get settings_double_tap_off => 'Désactivé';

  @override
  String get settings_double_tap_switch_cam => 'Changer de caméra';

  @override
  String get settings_double_tap_toggle_zoom => 'Activer/désactiver le zoom x2';

  @override
  String get settings_volume_action_title => 'Action des touches de volume';

  @override
  String get settings_volume_action_off => 'Ne rien faire';

  @override
  String get settings_volume_action_zoom => 'Contrôler le zoom';

  @override
  String get settings_volume_action_switch_cam => 'Changer de caméra';

  @override
  String get settings_volume_action_toggle_flash =>
      'Activer/désactiver la lampe torche';

  @override
  String get settings_remote_control_title => 'Contrôle à distance';

  @override
  String get settings_zoom_smoothing_title => 'Lissage du zoom';

  @override
  String get settings_zoom_smoothing_desc =>
      'Adoucit les changements de zoom des touches de volume et double-appui';

  @override
  String get settings_zoom_smoothing_dialog_title => 'Délai de lissage';

  @override
  String get settings_zoom_smoothing_none => 'Aucun (Instantané)';

  @override
  String get settings_power_title => 'Énergie et Écran';

  @override
  String get settings_power_ignore_optimizations =>
      'Ignorer les optimisations batterie';

  @override
  String get settings_power_ignore_optimizations_desc =>
      'Contourne les restrictions d\'énergie (ouvre les paramètres)';

  @override
  String get settings_power_auto_dim => 'Assombrir l\'écran auto.';

  @override
  String get settings_power_auto_dim_dialog_title =>
      'Assombrir l\'écran après...';

  @override
  String get settings_power_auto_dim_off => 'Désactivé';

  @override
  String get settings_power_auto_dim_45s => '45 secondes';

  @override
  String get settings_power_auto_dim_1m => '1 minute';

  @override
  String get settings_power_auto_dim_90s => '90 secondes';

  @override
  String get settings_power_auto_dim_2m => '2 minutes';

  @override
  String get settings_power_auto_dim_3m => '3 minutes';

  @override
  String get settings_power_auto_dim_5m => '5 minutes';

  @override
  String get settings_power_lock_input => 'Verrouiller au lieu d\'assombrir';

  @override
  String get settings_power_lock_input_desc => 'Empêche les appuis accidentels';

  @override
  String get settings_power_background_streaming => 'Streaming en arrière-plan';

  @override
  String get settings_power_background_streaming_desc =>
      'Garde le service actif lorsque l\'app est en fond';

  @override
  String get settings_power_allow_reconnects => 'Autoriser les reconnexions';

  @override
  String get settings_power_allow_reconnects_desc =>
      'Permet aux clients de se reconnecter au flux';

  @override
  String get settings_network_title => 'Réseau';

  @override
  String get settings_port_title => 'Port HTTP';

  @override
  String get settings_port_summary => 'Port utilisé par le flux MJPEG.';

  @override
  String get settings_port_dialog_title => 'Définir le Port HTTP';

  @override
  String get settings_port_dialog_label => 'Port (1025-65535)';

  @override
  String get settings_port_dialog_invalid =>
      'Port invalide. Doit être entre 1025 et 65535.';

  @override
  String get settings_app_title => 'Application';

  @override
  String get settings_additional_title => 'Paramètres supplémentaires';

  @override
  String get settings_about_app => 'Application';

  @override
  String get settings_about_title => 'À propos de RemoteCam';

  @override
  String get about_fork =>
      'Cette application est un fork amélioré, maintenu par @alananassss.';

  @override
  String get about_star => 'Star le repo sur GitHub';

  @override
  String get about_telegram =>
      'N\'hésitez pas à me contacter sur Telegram pour toute suggestion : @alananassss';

  @override
  String about_version(String version) {
    return 'Version $version';
  }

  @override
  String get egg_title_alan => 'Une petite note du dev :p';

  @override
  String get egg_message_alan =>
      'Salut ! C\'est Alan ^^\n\nC\'est drôle que tu aies cliqué 7 fois ici !\n\nJe voulais juste te dire merci. Cette app est un \'fork\', ce qui veut dire que j\'ai repris la super base du développeur original et que j\'y ai passé un temps fou (des jours et des jours, soirs et week-ends...) pour l\'améliorer à ma façon.\n\nJ\'espère vraiment qu\'elle te sert !\n\nMerci de l\'utiliser !\n- Alan';

  @override
  String get egg_button_alan => 'Cool ! Salutations !';

  @override
  String get h264_bitrate => 'Débit (Mbps)';

  @override
  String get h264_mode => 'Mode de débit';

  @override
  String get h264_mode_cbr => 'Constant (CBR - Faible Latence)';

  @override
  String get h264_mode_vbr => 'Variable (VBR - Qualité)';

  @override
  String get error_port_title => 'Port indisponible';

  @override
  String error_port_message(int port) {
    return 'Le port $port est déjà utilisé par une autre application. Veuillez en choisir un autre.';
  }

  @override
  String get btn_change_port => 'Changer de port';
}
