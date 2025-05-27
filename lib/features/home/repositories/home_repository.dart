import 'dart:io';

import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/failure/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepository();
}

class HomeRepository {
  Future<Either<AppFailure, String>> uploadSongData({
    required File selectedAudio,
    required File selectedImage,
    required String songName,
    required String artist,
    required String hexColor,
    required String token,
  }) async {
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse("${ServerConstant.serverURL}/song/upload"),
      );
      request
        ..files.addAll([
          await http.MultipartFile.fromPath("song", selectedAudio.path),
          await http.MultipartFile.fromPath("thumbnail", selectedImage.path),
        ])
        ..fields.addAll({
          "song_name": songName,
          "artist": artist,
          "hex_color": hexColor,
        })
        ..headers.addAll({
          "content-type": "multipart/form-data",
          "Authorization": "Bearer $token",
        });
      final response = await request.send();
      if (response.statusCode != 201) {
        return left(AppFailure(await response.stream.bytesToString()));
      }
      return right(await response.stream.bytesToString());
    } catch (e) {
      return left(AppFailure(e.toString()));
    }
  }
}
