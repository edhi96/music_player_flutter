import 'package:equatable/equatable.dart';
import 'package:music_player_flutter/features/home/domain/entities/music_entity.dart';

class MusicTable extends Equatable {
  final int? id;
  final String? artist;
  final String? url;
  final String? cover;
  final String? title;
  final int? trackTimeMillis;
  final String? artistUrl;
  final String? releaseDate;
  final String? longDescription;

  const MusicTable(
      {required this.id,
      required this.artist,
      required this.url,
      required this.cover,
      required this.title,
      required this.trackTimeMillis,
      required this.artistUrl,
      required this.releaseDate,
      required this.longDescription});

  factory MusicTable.fromEntity(MusicEntity musicEntity) => MusicTable(
        id: musicEntity.id,
        artist: musicEntity.artist,
        url: musicEntity.url,
        cover: musicEntity.cover,
        title: musicEntity.title,
        trackTimeMillis: musicEntity.trackTimeMillis,
        artistUrl: musicEntity.artistUrl,
        releaseDate: musicEntity.releaseDate,
        longDescription: musicEntity.longDescription,
      );

  factory MusicTable.fromMap(Map<String, dynamic> map) => MusicTable(
        id: map['id'],
        artist: map['artist'],
        url: map['url'],
        cover: map['cover'],
        title: map['title'],
        trackTimeMillis: map['trackTimeMillis'],
        artistUrl: map['artistUrl'],
        releaseDate: map['releaseDate'],
        longDescription: map['longDescription'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'artist': artist,
        'url': url,
        'cover': cover,
        'title': title,
        'trackTimeMillis': trackTimeMillis,
        'artistUrl': artistUrl,
        'releaseDate': releaseDate,
        'longDescription': longDescription,
      };

  @override
  List<Object?> get props =>
      [id, artist, url, cover, title, trackTimeMillis, artistUrl, releaseDate, longDescription];
}
