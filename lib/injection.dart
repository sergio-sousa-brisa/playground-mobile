import 'package:get_it/get_it.dart';
import 'package:playgroundmobile/repository/repository.dart';
import 'package:playgroundmobile/services/api_service.dart';
import 'package:playgroundmobile/stores/character/character.dart';
import 'package:playgroundmobile/stores/film/film.dart';
import 'package:playgroundmobile/stores/planet/planet.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<ApiService>(() => ApiService());

  getIt.registerLazySingleton<Repository>(
    () => Repository(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<FilmStore>(() => FilmStore(getIt<Repository>()));

  getIt.registerLazySingleton<CharacterStore>(
    () => CharacterStore(getIt<Repository>()),
  );

  getIt.registerLazySingleton<PlanetStore>(
    () => PlanetStore(getIt<Repository>()),
  );
}
