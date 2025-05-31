// ignore_for_file: avoid_public_notifier_properties
import 'package:client/features/home/model/song_model.dart';
import 'package:client/features/home/repositories/home_local_repository.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_song_notifier.g.dart';

@riverpod
class CurrentSongNotifier extends _$CurrentSongNotifier {
  bool isplaying = false;
  AudioPlayer? audioPlayer;
  late HomeLocalRepository _homeLocalRepository;

  @override
  SongModel? build() {
    _homeLocalRepository = ref.watch(homeLocalRepositoryProvider);
    return null;
  }

  void updateSong(SongModel song) async {
    await audioPlayer?.stop();
    audioPlayer = AudioPlayer();
    final mediaItem = MediaItem(
      id: song.id,
      title: song.song_name,
      artist: song.artist,
      album: song.song_name,
      artUri: Uri.parse(song.thumbnail),
    );
    final audioSource = AudioSource.uri(Uri.parse(song.song), tag: mediaItem);
    await audioPlayer!.setAudioSource(audioSource);
    audioPlayer!.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        audioPlayer!.seek(Duration.zero);
        audioPlayer!.pause();
        isplaying = false;
        this.state = this.state?.copyWith(hex_color: this.state?.hex_color);
      }
    });
    _homeLocalRepository.uploadLocalSong(song);
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

  void seek(double val) {
    audioPlayer!.seek(
      Duration(
        milliseconds: (val * audioPlayer!.duration!.inMilliseconds).toInt(),
      ),
    );
  }
}
