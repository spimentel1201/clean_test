import 'package:clean_architecture/core/util/input_converter.dart';
import 'package:clean_architecture/features/clean/domain/usecases/get_character.dart';
import 'package:clean_architecture/features/clean/domain/usecases/get_characters.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/platform/network.dart';
import 'features/clean/data/datasources/character_data_source.dart';
import 'features/clean/data/repositories/character_repository_impl.dart';
import 'features/clean/domain/repositories/character_repository.dart';
import 'features/clean/presentation/bloc/clean_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - character

  sl.registerFactory(
    () => CleanBloc(
      character: sl(),
      characters: sl(),
      inputConverter: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetCharacter(sl()));
  sl.registerLazySingleton(() => GetCharacters(sl()));

  //! Core
  sl.registerLazySingleton<Network>(() => NetworkImpl(sl()));
  sl.registerLazySingleton(() => InputConverter());

  //! Repository

  sl.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(
      characterDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //! Datasources

  sl.registerLazySingleton<CharacterDataSource>(
    () => CharacterDataSourceImpl(client: sl()),
  );

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
