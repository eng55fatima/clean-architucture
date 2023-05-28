import '../core/network/network_info.dart';
import '../data/data%20source/local%20data%20source/post_local_data_source.dart';
import '../data/data%20source/remote%20data%20source/post_remote_data_source.dart';
import '../data/repository_imp/post_repo_imp.dart';
import '../domain/repository/post_repo.dart';
import '../domain/usecase/addpost_usecase.dart';
import '../domain/usecase/delete_post_usecase.dart';
import '../domain/usecase/update_post_usecase.dart';
import '../presention/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import '../presention/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../domain/usecase/get_all_posts_usecase.dart';

final GetIt getIt = GetIt.instance;
Future<void> init() async {
//! feature - Posts

// Bloc

  getIt.registerFactory(() => PostsBloc(getAllPosts: getIt()));
  getIt.registerFactory(() => AddDeleteUpdatePostBloc(
        addPost: getIt(),
        updatePost: getIt(),
        deletePost: getIt(),
      ));

//UseCase
  getIt
      .registerLazySingleton(() => GetAllPostsUsecase(postRepository: getIt()));
  getIt.registerLazySingleton(() => AddPostUseCase(postRepository: getIt()));
  getIt.registerLazySingleton(() => UpdatePostUseCase(postRepository: getIt()));
  getIt.registerLazySingleton(() => DeletePostUsecase(postRepository: getIt()));

//Repository

  getIt.registerLazySingleton<PostRepository>(() => PostRepositoryImp(
      networkInfo: getIt(),
      postRemoteDataSource: getIt(),
      postLocalDataSource: getIt()));

//DataSource

  getIt.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImp(sharedPref: getIt()));
  getIt.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: getIt()));
//! Core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

//! External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  final Logger logger = Logger(
    printer: PrettyPrinter(methodCount: 0, errorMethodCount: 0, lineLength: 0));

  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => InternetConnectionChecker());
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => logger);
}
