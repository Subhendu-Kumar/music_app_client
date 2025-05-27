import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:flutter/material.dart';
import 'package:client/core/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/features/home/repositories/home_repository.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late HomeRepository _homeRepository;

  @override
  AsyncValue? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    return null;
  }

  Future<void> uploadSong({
    required String artist,
    required String songName,
    required File selectedAudio,
    required File selectedImage,
    required Color selectedColor,
  }) async {
    state = const AsyncValue.loading();
    final hexColor = rgbToHex(selectedColor);
    final token = ref.read(currentUserNotifierProvider)!.accessToken;
    final res = await _homeRepository.uploadSongData(
      token: token,
      artist: artist,
      songName: songName,
      hexColor: hexColor,
      selectedAudio: selectedAudio,
      selectedImage: selectedImage,
    );
    final val = switch (res) {
      Left(value: final l) =>
        state = AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r),
    };
    print(val);
  }
}
