import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:invonya_mobile/core/networks/network_info.dart';
import 'package:invonya_mobile/features/data/datasources/article/article_cache.dart';
import 'package:invonya_mobile/features/data/datasources/article/article_datasource_factory.dart';
import 'package:invonya_mobile/features/data/datasources/article/article_remote.dart';
import 'package:invonya_mobile/features/data/repositories/article_repository_impl.dart';

import '../core/networks/dio_client.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Blocs
  // sl.registerFactory(() => AuthCubit(sl(), sl(), sl()));

  ///! Use Cases
  // sl.registerLazySingleton(() => AuthUsecase(sl()));

  //! Repositories
  sl.registerLazySingleton(
    () => ArticleRepositoryImpl(sl(), sl()),
  );

  //! Datasources Factory
  sl.registerLazySingleton(() => ArticleDatasourceFactory(sl(), sl()));

  //! Datasources
  sl.registerLazySingleton(() => ArticleRemote(sl()));
  sl.registerLazySingleton(() => ArticleCache());

  //! Network Info
  sl.registerLazySingleton(() => NetworkInfoImpl(sl()));

  // //! External
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => sl<DioClient>().dio);
  sl.registerLazySingleton(() => DioClient("${dotenv.env['NEWS_BASE_URL']}"));
}
