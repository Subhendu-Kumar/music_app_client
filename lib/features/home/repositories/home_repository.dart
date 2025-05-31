import 'dart:io';
import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:client/core/failure/failure.dart';
import 'package:client/core/constants/server_constant.dart';
import 'package:client/features/home/model/song_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepository();
}

class HomeRepository {
  Future<Either<AppFailure, String>> uploadSongData({
    required String token,
    required String artist,
    required String hexColor,
    required String songName,
    required File selectedImage,
    required File selectedAudio,
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

  Future<Either<AppFailure, List<SongModel>>> listAllSongs({
    required String token,
  }) async {
    try {
      final res = await http.get(
        Uri.parse("${ServerConstant.serverURL}/song/list"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      var resBodyMap = jsonDecode(res.body);
      if (res.statusCode != 200) {
        resBodyMap = resBodyMap as Map<String, dynamic>;
        return left(AppFailure(resBodyMap["detail"]));
      }
      resBodyMap = resBodyMap as List;
      List<SongModel> songList = [];
      for (final map in resBodyMap) {
        songList.add(SongModel.fromMap(map));
      }
      return right(songList);
    } catch (e) {
      return left(AppFailure(e.toString()));
    }
  }
}
