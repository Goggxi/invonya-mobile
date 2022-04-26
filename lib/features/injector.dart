import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:invonya_mobile/core/networks/network_info.dart';
import 'package:invonya_mobile/features/data/datasources/article/article_datasource.dart';
import 'package:invonya_mobile/features/data/datasources/article/article_remote.dart';
import 'package:invonya_mobile/features/data/repositories/article_repository_impl.dart';
import 'package:invonya_mobile/features/domain/repositories/article_repositoty.dart';
import 'package:invonya_mobile/features/domain/usecases/get_article_topheadlines.dart';
import 'package:invonya_mobile/features/presentation/blocs/get_article_topheadlines/get_article_topheadlines_cubit.dart';

import '../core/networks/dio_client.dart';
import 'data/datasources/article/article_cache.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Blocs
  sl.registerFactory(() => GetArticleTopheadlinesCubit(sl()));

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
