import '../HttpReqstats/error_logic.dart';

/// A simple sound controller class for managing app sounds
class SoundsController {
  static final SoundsController _instance = SoundsController._internal();

  factory SoundsController() {
    return _instance;
  }

  SoundsController._internal();

  bool _soundEnabled = true;

  /// Get whether sound is enabled
  bool get isSoundEnabled => _soundEnabled;

  /// Enable or disable sound
  void setSoundEnabled(bool enabled) {
    _soundEnabled = enabled;
  }

  /// Play a sound (placeholder - implement with actual sound package)
  Future<void> playSound(String soundName) async {
    if (!_soundEnabled) return;

    // TODO: Implement actual sound playing logic
    // Example: await AudioPlayer().play(AssetSource('sounds/$soundName.mp3'));
    HdmLogger.log('Playing sound: $soundName', HdmLoggerMode.debug);
  }

  /// Play success sound
  Future<void> playSuccess() async {
    await playSound('success');
  }

  /// Play error sound
  Future<void> playError() async {
    await playSound('error');
  }

  /// Play notification sound
  Future<void> playNotification() async {
    await playSound('notification');
  }
}

/// Global instance for easy access
final SoundsController soundsController = SoundsController();
