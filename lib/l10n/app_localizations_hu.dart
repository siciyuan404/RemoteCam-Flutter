// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get app_name => 'RemoteCam';

  @override
  String get notif_title => 'RemoteCam (aktív)';

  @override
  String get notif_text => 'Koppintson a megnyitáshoz';

  @override
  String get notif_kill => 'Leállítás';

  @override
  String get perm_welcome => 'Üdvözli a RemoteCam alkalmazás';

  @override
  String get perm_welcome_title => 'Engedély szükséges';

  @override
  String get perm_desc =>
      'A működéshez az alkalmazásnak hozzá kell férnie a kamerához, és értesítéseket kell megjelenítenie.';

  @override
  String get perm_reasons_title => 'Miért kellenek ezek az engedélyek?';

  @override
  String get perm_cam_reason => 'Videó rögzítéséhez és streameléséhez.';

  @override
  String get perm_notif_reason =>
      'A szolgáltatás aktívan tartásához a háttérben.';

  @override
  String get perm_button => 'Engedélyek megadása';

  @override
  String get perm_toast_denied =>
      'Az alkalmazás használatához minden engedély szükséges.';

  @override
  String get cam_settings => 'Beállítások';

  @override
  String get cam_stop => 'STOP';

  @override
  String get cam_clipboard_copied => 'Vágólapra másolva';

  @override
  String get cam_controls => 'Vezérlők';

  @override
  String get cam_local_preview => 'Helyi előnézet';

  @override
  String get cam_mjpeg_stream => 'MJPEG Stream';

  @override
  String get cam_flash => 'Vaku';

  @override
  String get cam_flash_level => 'Fényerő';

  @override
  String get cam_parameters => 'Paraméterek';

  @override
  String get cam_sensor => 'Érzékelő';

  @override
  String get cam_resolution => 'Felbontás';

  @override
  String get cam_quality => 'JPEG minőség';

  @override
  String get cam_information => 'Információ';

  @override
  String get cam_overlay_locked =>
      'A képernyő elsötétítve és zárolva. Koppintson a feloldáshoz.';

  @override
  String get settings_title => 'Beállítások';

  @override
  String get settings_back => 'Vissza';

  @override
  String get settings_close => 'Bezárás';

  @override
  String get settings_save => 'Mentés';

  @override
  String get settings_appearance => 'Megjelenés';

  @override
  String get settings_theme => 'Téma';

  @override
  String get settings_theme_auto => 'Automatikus (rendszer)';

  @override
  String get settings_theme_light => 'Világos';

  @override
  String get settings_theme_dark => 'Sötét';

  @override
  String get settings_monet => 'Dinamikus szín (Monet)';

  @override
  String get settings_language => 'Nyelv';

  @override
  String get settings_lang_auto => 'Automatikus (rendszer)';

  @override
  String get settings_lang_en => 'English (Angol)';

  @override
  String get settings_lang_fr => 'Français (Francia)';

  @override
  String get settings_lang_hu => 'Magyar';

  @override
  String get settings_lang_pt_br => 'Português (Portugál)';

  @override
  String get settings_behavior_title => 'Viselkedés';

  @override
  String get settings_keep_screen_on => 'Képernyő bekapcsolva tartása';

  @override
  String get settings_camera_title => 'Kamera';

  @override
  String get settings_remember_title => 'Kamerabeállítások megjegyzése';

  @override
  String get settings_remember_desc =>
      'Indításkor alkalmazza a mentett beállításokat';

  @override
  String get settings_remember_dialog_title => 'Megjegyzés...';

  @override
  String get settings_remember_sensor => 'Kameraérzékelő';

  @override
  String get settings_remember_resolution => 'Felbontás';

  @override
  String get settings_remember_quality => 'JPEG minőség';

  @override
  String get settings_remember_flash => 'Vaku állapota';

  @override
  String get settings_remember_zoom => 'Zoom szint';

  @override
  String get settings_remember_h264 => 'H.264 beállítások';

  @override
  String get settings_fps_title => 'Cél FPS';

  @override
  String get settings_stabilization_title => 'Stabilizálás letiltása (OIS/EIS)';

  @override
  String get settings_stabilization_desc =>
      'Javítja a késleltetést állvány használatakor';

  @override
  String get settings_flicker_title => 'Villódzásgátló';

  @override
  String get settings_flicker_auto => 'Automatikus';

  @override
  String get settings_flicker_off => 'Ki';

  @override
  String get settings_flicker_50hz => '50Hz (Európa, Ázsia)';

  @override
  String get settings_flicker_60hz => '60Hz (Észak-Amerika)';

  @override
  String get settings_noise_reduction_title => 'Zajcsökkentés';

  @override
  String get settings_noise_reduction_auto => 'Automatikus';

  @override
  String get settings_noise_reduction_off => 'Ki';

  @override
  String get settings_noise_reduction_low => 'Alacsony (gyors)';

  @override
  String get settings_noise_reduction_high => 'Magas (jobb minőség)';

  @override
  String get settings_format_title => 'Stream formátum';

  @override
  String get settings_format_desc => 'A HTTP stream formátuma';

  @override
  String get settings_format_mjpeg => 'MJPEG';

  @override
  String get settings_format_mjpeg_desc => 'Képek';

  @override
  String get settings_format_h264 => 'H.264';

  @override
  String get settings_format_h264_desc => 'Videó - Hatékony';

  @override
  String get settings_controls_title => 'Vezérlők';

  @override
  String get settings_double_tap_title => 'Dupla koppintás művelete';

  @override
  String get settings_double_tap_off => 'Ki';

  @override
  String get settings_double_tap_switch_cam => 'Kameraváltás';

  @override
  String get settings_double_tap_toggle_zoom => '2x zoom váltása';

  @override
  String get settings_volume_action_title => 'Hangerőgomb művelet';

  @override
  String get settings_volume_action_off => 'Nincs művelet';

  @override
  String get settings_volume_action_zoom => 'Zoom vezérlés';

  @override
  String get settings_volume_action_switch_cam => 'Kameraváltás';

  @override
  String get settings_volume_action_toggle_flash => 'Vaku váltása';

  @override
  String get settings_remote_control_title => 'Távirányító';

  @override
  String get settings_zoom_smoothing_title => 'Zoom simítás';

  @override
  String get settings_zoom_smoothing_desc =>
      'Simítja a hangerőgombok és a dupla koppintás által végzett zoomváltozásokat';

  @override
  String get settings_zoom_smoothing_dialog_title => 'Simítási késleltetés';

  @override
  String get settings_zoom_smoothing_none => 'Nincs (azonnali)';

  @override
  String get settings_power_title => 'Energia és képernyő';

  @override
  String get settings_power_ignore_optimizations =>
      'Akkumulátor-optimalizálás figyelmen kívül hagyása';

  @override
  String get settings_power_ignore_optimizations_desc =>
      'Energiatakarékos funkciók megkerülése (rendszerbeállításokat nyit meg)';

  @override
  String get settings_power_auto_dim => 'Képernyő automatikus sötétítése';

  @override
  String get settings_power_auto_dim_dialog_title =>
      'Képernyő sötétítése ennyi idő után...';

  @override
  String get settings_power_auto_dim_off => 'Ki';

  @override
  String get settings_power_auto_dim_45s => '45 másodperc';

  @override
  String get settings_power_auto_dim_1m => '1 perc';

  @override
  String get settings_power_auto_dim_90s => '90 másodperc';

  @override
  String get settings_power_auto_dim_2m => '2 perc';

  @override
  String get settings_power_auto_dim_3m => '3 perc';

  @override
  String get settings_power_auto_dim_5m => '5 perc';

  @override
  String get settings_power_lock_input => 'Bemenet zárolása sötétítéskor';

  @override
  String get settings_power_lock_input_desc =>
      'Megakadályozza a véletlen bevitelt';

  @override
  String get settings_power_background_streaming =>
      'Háttérben történő streamelés';

  @override
  String get settings_power_background_streaming_desc =>
      'A szolgáltatás aktívan tartása, ha az alkalmazás a háttérben van';

  @override
  String get settings_power_allow_reconnects => 'Újracsatlakozás engedélyezése';

  @override
  String get settings_power_allow_reconnects_desc =>
      'Lehetővé teszi a kliensek számára, hogy újracsatlakozzanak a streamhez';

  @override
  String get settings_network_title => 'Hálózat';

  @override
  String get settings_port_title => 'HTTP-port';

  @override
  String get settings_port_summary => 'Az MJPEG stream által használt port.';

  @override
  String get settings_port_dialog_title => 'HTTP-port beállítása';

  @override
  String get settings_port_dialog_label => 'Port (1025–65535)';

  @override
  String get settings_port_dialog_invalid =>
      'Érvénytelen port. 1025 és 65535 között kell lennie.';

  @override
  String get settings_app_title => 'Alkalmazás';

  @override
  String get settings_additional_title => 'További beállítások';

  @override
  String get settings_about_app => 'Az alkalmazásról';

  @override
  String get settings_about_title => 'A RemoteCam névjegye';

  @override
  String get about_fork =>
      'Ez az alkalmazás egy továbbfejlesztett fork, karbantartója: @alananassss.';

  @override
  String get about_star => 'Csillagozza a repót GitHubon';

  @override
  String get about_telegram =>
      'Keressen bátran Telegramon javaslatokkal: @alananassss';

  @override
  String about_version(String version) {
    return 'Verzió $version';
  }

  @override
  String get egg_title_alan => 'Egy kis üzenet a fejlesztőtől :p';

  @override
  String get egg_message_alan =>
      'Szia! Alan vagyok ^^\n\nVicces, hogy hétszer koppintottál ide!\n\nCsak köszönetet akartam mondani. Ez az app egy „fork\", ami azt jelenti, hogy az eredeti fejlesztő fantasztikus alapját vettem, és rengeteg időt (napokat, estéket és hétvégéket...) töltöttem a saját fejlesztéseim hozzáadásával.\n\nNagyon remélem, hogy hasznosnak találod!\n\nKöszi, hogy használod!\n- Alan';

  @override
  String get egg_button_alan => 'Király! Üdv!';

  @override
  String get h264_bitrate => 'Bitráta (Mbps)';

  @override
  String get h264_mode => 'Bitráta mód';

  @override
  String get h264_mode_cbr => 'Állandó (CBR - Alacsony késleltetés)';

  @override
  String get h264_mode_vbr => 'Változó (VBR - Minőség)';

  @override
  String get error_port_title => 'Port nem elérhető';

  @override
  String error_port_message(int port) {
    return 'A(z) $port port már használatban van egy másik alkalmazás által. Kérjük, válasszon másikat.';
  }

  @override
  String get btn_change_port => 'Port módosítása';
}
