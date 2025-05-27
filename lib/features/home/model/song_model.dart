// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class SongModel {
  final String id;
  final String song_name;
  final String artist;
  final String hex_color;
  final String song;
  final String thumbnail;

  SongModel({
    required this.id,
    required this.song_name,
    required this.artist,
    required this.hex_color,
    required this.song,
    required this.thumbnail,
  });

  SongModel copyWith({
    String? id,
    String? song_name,
    String? artist,
    String? hex_color,
    String? song,
    String? thumbnail,
  }) {
    return SongModel(
      id: id ?? this.id,
      song_name: song_name ?? this.song_name,
      artist: artist ?? this.artist,
      hex_color: hex_color ?? this.hex_color,
      song: song ?? this.song,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'song_name': song_name,
      'artist': artist,
      'hex_color': hex_color,
      'song': song,
      'thumbnail': thumbnail,
    };
  }

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      id: map['id'] ?? "",
      song_name: map['song_name'] ?? "",
      artist: map['artist'] ?? "",
      hex_color: map['hex_color'] ?? "",
      song: map['song'] ?? "",
      thumbnail: map['thumbnail'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory SongModel.fromJson(String source) =>
      SongModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SongModel(id: $id, song_name: $song_name, artist: $artist, hex_color: $hex_color, song: $song, thumbnail: $thumbnail)';
  }

  @override
  bool operator ==(covariant SongModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.song_name == song_name &&
        other.artist == artist &&
        other.hex_color == hex_color &&
        other.song == song &&
        other.thumbnail == thumbnail;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        song_name.hashCode ^
        artist.hashCode ^
        hex_color.hashCode ^
        song.hashCode ^
        thumbnail.hashCode;
  }
}
