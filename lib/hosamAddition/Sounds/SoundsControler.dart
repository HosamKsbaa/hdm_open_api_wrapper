// import 'package:flutter/services.dart';
// import 'package:soundpool/soundpool.dart';

// enum SoundEffect {
//   cashRegister,
//   storeScanner,
// }

// class SoundController {
//   final Soundpool _pool;
//   final Map<SoundEffect, int> _soundIds = {};

//   SoundController()
//       : _pool = Soundpool.fromOptions(
//             options: SoundpoolOptions(
//           streamType: StreamType.ring,
//           maxStreams: 1,
//         ));

//   Future<void> init() async {
//     _soundIds[SoundEffect.cashRegister] = await _loadSound('assets/SoundEffect/cash-register.mp3');
//     _soundIds[SoundEffect.storeScanner] = await _loadSound('assets/SoundEffect/store-scanner.mp3');
//   }

//   Future<int> _loadSound(String assetPath) async {
//     return await rootBundle.load(assetPath).then((ByteData soundData) {
//       return _pool.load(soundData);
//     });
//   }

//   Future<void> playSound(SoundEffect effect) async {
//     print("soudn  onnnnnnnnn");
//     int? soundId = _soundIds[effect];
//     if (soundId != null) {
//       await _pool.playWithControls(soundId, rate: 1.0, repeat: 0);
//     }
//   }
// }
