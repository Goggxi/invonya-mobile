import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import '../core/core.dart';
import 'features.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Blocs
  sl.registerFactory(() => GetArticleTopheadlinesCubit(sl()));
  sl.registerFactory(() => GetArticleTopheadlinesCategoryCubit(sl()));

  ///! Use Cases
  sl.registerLazySingleton(() => GetArticleTopHeadlines(sl()));

  //! Repositories
  sl.registerLazySingleton<ArticleRepository>(
    () => ArticleRepositoryImpl(sl(), sl(), sl()),
  );

  //! Datasources
  sl.registerLazySingleton<ArticleRemoteDatasource>(() => ArticleRemote(sl()));
  sl.registerLazySingleton<ArticleLoaclDatasource>(() => ArticleCache());

  //! Network Info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // //! External
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => sl<DioClient>().dio);
  sl.registerLazySingleton(() => DioClient("${dotenv.env['NEWS_BASE_URL']}"));
}
