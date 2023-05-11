import 'package:music_player_flutter/features/home/domain/repositories/detail_music_repository.dart';

class GetStatusFavouriteUseCase {
  final DetailMusicRepository repository;

  GetStatusFavouriteUseCase(this.repository);

  Future<bool> execute(int? idMusic) async {
    final result = await repository.isAddedToFavourite(idMusic ?? 0);
    return result.fold(
      (failure) {
        return false;
      },
      (result) {
        return result?.id != null ? true : false;
      },
    );
  }
}
