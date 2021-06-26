//import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nouveau_projet/models/Chanson.dart';

class AudioManager{

  //AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  Chanson chanson;
// var url = chanson.audioUrl;
  // static const url = "https://www.soundhelix.com/examples/mp3/SoundHelix...";
   AudioPlayer _audioPlayer;
  AudioManager(this.chanson) {
    print("construct");
    _init();
    print("end construct");
  }
  void _init() async {
    print("init audio player");
    _audioPlayer = AudioPlayer();
    await _audioPlayer.setUrl(chanson.audioUrl);

    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        buttonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        buttonNotifier.value = ButtonState.paused;
      } else {
        buttonNotifier.value = ButtonState.playing;
      }
    });
    _audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });
    _audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
    print("init audio end");
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void play() {
    _audioPlayer.play();
  }
  void pause() {
    _audioPlayer.pause();
  }
  void dispose() {
    _audioPlayer.dispose();
  }


  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );
  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);

}
class ProgressBarState {
  ProgressBarState({
     this.current,
     this.buffered,
     this.total,
  });
  final Duration current;
  final Duration buffered;
  final Duration total;
}
enum ButtonState {
  paused, playing, loading
}

