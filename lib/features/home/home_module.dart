import 'package:http/http.dart' as http;
import 'package:music_player_flutter/features/home/data/datasources/database_helper.dart';
import 'package:music_player_flutter/features/home/data/datasources/favourite_local_ds.dart';
import 'package:music_player_flutter/features/home/data/repositories/home_repository_impl.dart';
import 'package:music_player_flutter/features/home/domain/usecases/list_favourite_use_case.dart';
import 'package:music_player_flutter/features/home/domain/usecases/search_music_use_case.dart';
import 'package:music_player_flutter/features/home/presentation/provider/audio_provider.dart';
import 'package:music_player_flutter/features/home/presentation/provider/detail_notifier.dart';
import 'package:music_player_flutter/features/home/presentation/provider/search_notifier.dart';

import '../../common/client_http.dart';
import '../../main.dart';
import 'data/datasources/home_remote_ds.dart';
import 'data/repositories/detail_music_repository_impl.dart';
import 'domain/repositories/detail_music_repository.dart';
import 'domain/repositories/home_repository.dart';
import 'domain/usecases/add_to_favourite_use_case.dart';
import 'domain/usecases/get_status_favourite_use_case.dart';
import 'domain/usecases/remove_favourite_use_case.dart';

class HomeModule {
  static void init() {
    locator.registerLazySingleton<ClientHttp>(
      () => ClientHttp(http.Client(), 'https://itunes.apple.com'),
    );

    locator.registerLazySingleton<DatabaseHelper>(
      () => DatabaseHelper(),
    );

    locator.registerLazySingleton<FavouriteLocalDataSource>(
      () => FavouriteLocalDataSourceImpl(databaseHelper: locator()),
    );

    locator.registerLazySingleton<DetailMusicRepository>(
      () => DetailMusicRepositoryImpl(favouriteLocalDataSource: locator()),
    );

    locator.registerFactory(
      () => AddToFavouriteUseCase(
        locator(),
      ),
    );

    locator.registerFactory(
      () => RemoveFavouriteUseCase(
        locator(),
      ),
    );

    locator.registerFactory(
      () => GetStatusFavouriteUseCase(
        locator(),
      ),
    );

    locator.registerFactory(
      () => DetailNotifier(addToFavouriteUseCase: locator(), statusFavouriteUseCase: locator(), removeFavouriteUseCase: locator()),
    );

    locator.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(client: locator()),
    );
    locator.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(remoteDataSource: locator(), favouriteLocalDataSource: locator()),
    );

    locator.registerLazySingleton(
      () => SearchMusicUseCase(locator()),
    );

    locator.registerLazySingleton(
      () => ListFavouriteUseCase(locator()),
    );

    locator.registerFactory(
      () => SearchNotifier(searchMusicUseCase: locator(), listFavouriteUseCase: locator()),
    );
    locator.registerFactory(
      () => AudioProvider(),
    );
  }
}
