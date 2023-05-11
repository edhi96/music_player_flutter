import 'package:equatable/equatable.dart';

import 'music_model.dart';

class MusicResponse<T> extends Equatable {
  final int? resultCount;
  final List<MusicModel> results;

  const MusicResponse({required this.results, required this.resultCount});

  factory MusicResponse.fromJson(Map<String, dynamic> json) => MusicResponse(
        resultCount: json["resultCount"] ?? 0,
        results: List<MusicModel>.from(
          json["results"].map(
            (x) => MusicModel.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {"resultCount": resultCount ?? 0, "results": List<MusicModel>.from(results.map((x) => x.toJson()))};

  @override
  List<Object?> get props => [resultCount, results];
}
