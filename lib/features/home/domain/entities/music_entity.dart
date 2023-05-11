import 'package:equatable/equatable.dart';

class MusicEntity extends Equatable {
  const MusicEntity(
      {required this.id,
      required this.artist,
      required this.url,
      required this.cover,
      required this.title,
      required this.trackTimeMillis,
      required this.artistUrl,
      required this.releaseDate,
      required this.longDescription});

  final int id;

  final String title;

  final String artist;

  final String cover;

  final String url;

  final String artistUrl;

  final int trackTimeMillis;

  final String releaseDate;

  final String longDescription;

  @override
  List<Object?> get props =>
      [id, artist, url, cover, title, trackTimeMillis, artistUrl, releaseDate, longDescription];
}
