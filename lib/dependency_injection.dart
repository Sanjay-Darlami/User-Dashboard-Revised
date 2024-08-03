import 'package:demo_revised_project/bloc/album/album_bloc.dart';
import 'package:demo_revised_project/bloc/comment/comment_bloc.dart';
import 'package:demo_revised_project/bloc/photo/photo_bloc.dart';
import 'package:demo_revised_project/bloc/post/post_bloc.dart';
import 'package:demo_revised_project/bloc/todos/todos_bloc.dart';
import 'package:demo_revised_project/bloc/user/user_bloc.dart';
import 'package:demo_revised_project/network/app_api.dart';
import 'package:demo_revised_project/repository/album_repository.dart';
import 'package:demo_revised_project/repository/photo_repository.dart';
import 'package:demo_revised_project/repository/post_repository.dart';
import 'package:demo_revised_project/repository/todos_repository.dart';
import 'package:demo_revised_project/repository/user_repository.dart';
import 'package:demo_revised_project/shared_preferences/data_storage.dart';
import 'package:demo_revised_project/shared_preferences/local_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDependencyInjection() async {
  await initDio();
  await initSharedPreferences();
  registerRepositories();
  registerBlocs();
}

Future<void> initDio() async {
  getIt.registerSingleton(buildDio());
}

Future<void> initSharedPreferences() async {
  getIt.registerSingletonAsync<SharedPreferences>(
    () async => await buildSharedPreferences(),
  );
  await getIt.allReady();
  getIt.registerLazySingleton<LocalDataSource>(
      () => DataStorage(prefs: getIt<SharedPreferences>()));
}

void registerRepositories() {
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepository(dio: getIt()),
  );

  getIt.registerLazySingleton<PostRepository>(
      (() => PostRepository(dio: getIt(), localDataStorage: getIt())));

  getIt.registerLazySingleton<AlbumRepository>(
      (() => AlbumRepository(dio: getIt())));

  getIt.registerLazySingleton<PhotoRepository>(
      (() => PhotoRepository(dio: getIt())));

  getIt.registerLazySingleton<TodosRepository>(
      (() => TodosRepository(dio: getIt())));
}

void registerBlocs() {
  getIt.registerLazySingleton<UserBloc>(
      (() => UserBloc(userRepository: getIt())));

  getIt.registerLazySingleton<PostBloc>(
      (() => PostBloc(postRepository: getIt())));

  getIt.registerLazySingleton<AlbumBloc>(
      (() => AlbumBloc(albumRepository: getIt())));

  getIt.registerLazySingleton<PhotoBloc>(
      (() => PhotoBloc(photoRepository: getIt())));

  getIt.registerLazySingleton<CommentsBloc>(
      (() => CommentsBloc(postRepository: getIt())));

  getIt.registerLazySingleton<TodosBloc>(
      (() => TodosBloc(todosRepository: getIt())));
}
