import 'package:flutter/material.dart';
import 'package:client/core/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:client/core/theme/pallete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/core/providers/current_song_notifier.dart';
import 'package:client/features/home/view/widgets/music_player.dart';

class MusicSlab extends ConsumerWidget {
  const MusicSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongNotifierProvider);
    final songNotifier = ref.watch(currentSongNotifierProvider.notifier);

    if (currentSong == null) {
      return const SizedBox();
    }

    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: 65,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: hexToColor(currentSong.hex_color),
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const MusicPlayer();
                      },
                      transitionsBuilder: (
                        context,
                        animation,
                        secondaryAnimation,
                        child,
                      ) {
                        final tween = Tween(
                          begin: Offset(0, 1),
                          end: Offset.zero,
                        ).chain(CurveTween(curve: Curves.easeInOut));
                        final offSetAnimation = animation.drive(tween);
                        return SlideTransition(
                          position: offSetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: "${currentSong.id}_image",
                      child: Container(
                        width: 45,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(currentSong.thumbnail),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          currentSong.song_name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Artist: ${currentSong.artist}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Pallete.subtitleText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_border_outlined,
                      color: Pallete.whiteColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: songNotifier.playPause,
                    icon: Icon(
                      songNotifier.isplaying
                          ? CupertinoIcons.pause_fill
                          : CupertinoIcons.play_fill,
                      color: Pallete.whiteColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        StreamBuilder(
          stream: songNotifier.audioPlayer!.positionStream,
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            }
            final position = asyncSnapshot.data;
            final duration = songNotifier.audioPlayer!.duration;
            double sliderValue = 0.0;
            if (position != null && duration != null) {
              sliderValue = position.inMilliseconds / duration.inMilliseconds;
            }
            return Positioned(
              left: 10,
              bottom: 0,
              child: Container(
                height: 2,
                width: sliderValue * (MediaQuery.of(context).size.width - 20),
                decoration: BoxDecoration(
                  color: Pallete.whiteColor,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            );
          },
        ),
        Positioned(
          left: 10,
          bottom: 0,
          child: Container(
            height: 2,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              color: Pallete.inactiveSeekColor,
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
      ],
    );
  }
}
