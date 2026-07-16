// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get app_name => 'RemoteCam';

  @override
  String get notif_title => 'RemoteCam (ativo)';

  @override
  String get notif_text => 'Toque para abrir';

  @override
  String get notif_kill => 'Fechar';

  @override
  String get perm_welcome => 'Bem-vindo(a) ao RemoteCam';

  @override
  String get perm_welcome_title => 'Autorização Necessária';

  @override
  String get perm_desc =>
      'Para funcionar, o app precisa do acesso à sua câmera e para exibir notificações.';

  @override
  String get perm_reasons_title => 'Por que essas permissões?';

  @override
  String get perm_cam_reason => 'Para capturar e transmitir vídeo.';

  @override
  String get perm_notif_reason =>
      'Para manter o serviço ativo em segundo plano.';

  @override
  String get perm_button => 'Conceder permissões';

  @override
  String get perm_toast_denied =>
      'Todas as permissões são necessárias para usar o aplicativo.';

  @override
  String get cam_settings => 'Configurações';

  @override
  String get cam_stop => 'PARAR';

  @override
  String get cam_clipboard_copied => 'Copiado para a área de transferência';

  @override
  String get cam_controls => 'Controles';

  @override
  String get cam_local_preview => 'Prévia local';

  @override
  String get cam_mjpeg_stream => 'Transmissão em MJPEG';

  @override
  String get cam_flash => 'Lanterna';

  @override
  String get cam_flash_level => 'Intensidade';

  @override
  String get cam_parameters => 'Parâmetros';

  @override
  String get cam_sensor => 'Sensor';

  @override
  String get cam_resolution => 'Resolução';

  @override
  String get cam_quality => 'Qualidade do JPEG';

  @override
  String get cam_information => 'Informação';

  @override
  String get cam_overlay_locked =>
      'Tela escurecida e bloqueada. Toque para desbloquear.';

  @override
  String get settings_title => 'Configurações';

  @override
  String get settings_back => 'Voltar';

  @override
  String get settings_close => 'Fechar';

  @override
  String get settings_save => 'Salvar';

  @override
  String get settings_appearance => 'Aparência';

  @override
  String get settings_theme => 'Tema';

  @override
  String get settings_theme_auto => 'Automático (Sistema)';

  @override
  String get settings_theme_light => 'Claro';

  @override
  String get settings_theme_dark => 'Escuro';

  @override
  String get settings_monet => 'Cor Dinâmica (Monet)';

  @override
  String get settings_language => 'Idioma';

  @override
  String get settings_lang_auto => 'Automático (Sistema)';

  @override
  String get settings_lang_en => 'English (Inglês)';

  @override
  String get settings_lang_fr => 'Français (Francês)';

  @override
  String get settings_lang_hu => 'Magyar (Húngaro)';

  @override
  String get settings_lang_pt_br => 'Português (Brasileiro)';

  @override
  String get settings_behavior_title => 'Comportamento';

  @override
  String get settings_keep_screen_on => 'Manter a tela ativa';

  @override
  String get settings_camera_title => 'Câmera';

  @override
  String get settings_remember_title => 'Lembrar as configurações da câmera';

  @override
  String get settings_remember_desc =>
      'Aplica as configurações salvas na inicialização';

  @override
  String get settings_remember_dialog_title => 'Lembrar...';

  @override
  String get settings_remember_sensor => 'Sensor da Câmera';

  @override
  String get settings_remember_resolution => 'Resolução';

  @override
  String get settings_remember_quality => 'Qualidade do JPEG';

  @override
  String get settings_remember_flash => 'Estado do flash';

  @override
  String get settings_remember_zoom => 'Nível do zoom';

  @override
  String get settings_remember_h264 => 'Configurações H.264';

  @override
  String get settings_fps_title => 'FPS Alvo';

  @override
  String get settings_stabilization_title =>
      'Desabilitar estabilização (OIS/EIS)';

  @override
  String get settings_stabilization_desc => 'Melhora a latência em um tripé';

  @override
  String get settings_flicker_title => 'Anti-Flicker';

  @override
  String get settings_flicker_auto => 'Automático';

  @override
  String get settings_flicker_off => 'Desativado';

  @override
  String get settings_flicker_50hz => '50Hz (Europa, Ásia)';

  @override
  String get settings_flicker_60hz => '60Hz (América do Norte)';

  @override
  String get settings_noise_reduction_title => 'Redução de Ruído';

  @override
  String get settings_noise_reduction_auto => 'Automático';

  @override
  String get settings_noise_reduction_off => 'Desativado';

  @override
  String get settings_noise_reduction_low => 'Baixo (Rápido)';

  @override
  String get settings_noise_reduction_high => 'Alto (Alta Qualidade)';

  @override
  String get settings_format_title => 'Formato de transmissão';

  @override
  String get settings_format_desc => 'Formato usado para a transmissão HTTP';

  @override
  String get settings_format_mjpeg => 'MJPEG';

  @override
  String get settings_format_mjpeg_desc => 'Imagens';

  @override
  String get settings_format_h264 => 'H.264';

  @override
  String get settings_format_h264_desc => 'Vídeo - Eficiente';

  @override
  String get settings_controls_title => 'Controles';

  @override
  String get settings_double_tap_title => 'Ação ao toque duplo';

  @override
  String get settings_double_tap_off => 'Desativado';

  @override
  String get settings_double_tap_switch_cam => 'Trocar de câmera';

  @override
  String get settings_double_tap_toggle_zoom => 'Alternar o zoom em 2x';

  @override
  String get settings_volume_action_title => 'Ação aos botões de volume';

  @override
  String get settings_volume_action_off => 'Não fazer nada';

  @override
  String get settings_volume_action_zoom => 'Controlar o zoom';

  @override
  String get settings_volume_action_switch_cam => 'Trocar de câmera';

  @override
  String get settings_volume_action_toggle_flash => 'Alternar a lanterna';

  @override
  String get settings_remote_control_title => 'Controle remoto';

  @override
  String get settings_zoom_smoothing_title => 'Suavização no Zoom';

  @override
  String get settings_zoom_smoothing_desc =>
      'Suaviza as mudanças no zoom das teclas de volume e do toque duplo';

  @override
  String get settings_zoom_smoothing_dialog_title => 'Atraso de Suavização';

  @override
  String get settings_zoom_smoothing_none => 'Nenhum (Instantâneo)';

  @override
  String get settings_power_title => 'Energia e Tela';

  @override
  String get settings_power_ignore_optimizations =>
      'Ignorar as otimizações de bateria';

  @override
  String get settings_power_ignore_optimizations_desc =>
      'Contornar as funções de economia de bateria (abre as configurações do sistema)';

  @override
  String get settings_power_auto_dim => 'Escurecer a tela automaticamente';

  @override
  String get settings_power_auto_dim_dialog_title => 'Escurecer a tela após...';

  @override
  String get settings_power_auto_dim_off => 'Desativado';

  @override
  String get settings_power_auto_dim_45s => '45 segundos';

  @override
  String get settings_power_auto_dim_1m => '1 minuto';

  @override
  String get settings_power_auto_dim_90s => '90 segundos';

  @override
  String get settings_power_auto_dim_2m => '2 minutos';

  @override
  String get settings_power_auto_dim_3m => '3 minutos';

  @override
  String get settings_power_auto_dim_5m => '5 minutos';

  @override
  String get settings_power_lock_input =>
      'Bloquear entrada quando a tela escurecer';

  @override
  String get settings_power_lock_input_desc => 'Impede toques acidentais';

  @override
  String get settings_power_background_streaming =>
      'Transmissão em segundo plano';

  @override
  String get settings_power_background_streaming_desc =>
      'Mantém o serviço ativo quando o app estiver em segundo plano';

  @override
  String get settings_power_allow_reconnects => 'Permitir reconexões';

  @override
  String get settings_power_allow_reconnects_desc =>
      'Permitir o cliente reconectar à transmissão';

  @override
  String get settings_network_title => 'Rede';

  @override
  String get settings_port_title => 'Porta HTTP';

  @override
  String get settings_port_summary => 'Porta usada pela transmissão MJPEG.';

  @override
  String get settings_port_dialog_title => 'Define uma porta HTTP';

  @override
  String get settings_port_dialog_label => 'Porta (1025-65535)';

  @override
  String get settings_port_dialog_invalid =>
      'Porta inválida. Precisa ser entre 1025 e 65535.';

  @override
  String get settings_app_title => 'Aplicativo';

  @override
  String get settings_additional_title => 'Configurações Adicionais';

  @override
  String get settings_about_app => 'Aplicativo';

  @override
  String get settings_about_title => 'Sobre o RemoteCam';

  @override
  String get about_fork =>
      'Este aplicativo é uma versão melhorada, mantido por @alananassss.';

  @override
  String get about_star => 'Dê uma estrela no GitHub';

  @override
  String get about_telegram =>
      'Fique à vontade para me contatar no Telegram para qualquer sugestão: @alananassss';

  @override
  String about_version(String version) {
    return 'Versão $version';
  }

  @override
  String get egg_title_alan => 'Um pouquinho mais do dev :p';

  @override
  String get egg_message_alan =>
      'Olá! Alan aqui ^^\n\nEngraçado que você clicou 7 vezes para chegar aqui!\n\nApenas queria dizer obrigado. Este app é um \'fork\', que significa que eu peguei a base incrível do desenvolvedor original e gastei bastante tempo adicionando minhas próprias melhorias (dias e dias, noites e fins de semanas...).\n\nEspero sinceramente que você ache isso útil!\n\nObrigado por usar!\n- Alan';

  @override
  String get egg_button_alan => 'Legal! Saudações!';

  @override
  String get h264_bitrate => 'Taxa de bits (Mbps)';

  @override
  String get h264_mode => 'Modo de taxa de bits';

  @override
  String get h264_mode_cbr => 'Constante (CBR - Baixa Latência)';

  @override
  String get h264_mode_vbr => 'Variável (VBR - Qualidade)';

  @override
  String get error_port_title => 'Porta indisponível';

  @override
  String error_port_message(int port) {
    return 'A porta $port já está em uso por outro aplicativo. Por favor, escolha outra.';
  }

  @override
  String get btn_change_port => 'Alterar Porta';
}
