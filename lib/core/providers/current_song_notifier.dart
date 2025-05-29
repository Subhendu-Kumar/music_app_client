// ignore_for_file: avoid_public_notifier_properties
import 'package:client/features/home/model/song_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_song_notifier.g.dart';

@riverpod
class CurrentSongNotifier extends _$CurrentSongNotifier {
  AudioPlayer? audioPlayer;
  bool isplaying = false;

  @override
  SongModel? build() {
    return null;
  }

  void updateSong(SongModel song) async {
    audioPlayer = AudioPlayer();
    final audioSource = AudioSource.uri(Uri.parse(song.song));
    await audioPlayer!.setAudioSource(audioSource);
    audioPlayer!.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        audioPlayer!.seek(Duration.zero);
        audioPlayer!.pause();
        isplaying = false;
        this.state = this.state?.copyWith(hex_color: this.state?.hex_color);
      }
    });
    audioPlayer!.play();
    isplaying = true;
    state = song;
  }

  void playPause() {
    if (isplaying) {
      audioPlayer?.pause();
    } else {
      audioPlayer?.play();
    }
    isplaying = !isplaying;
    state = state?.copyWith(hex_color: state?.hex_color);
  }
}
