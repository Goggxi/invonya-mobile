import 'package:dartz/dartz.dart';
import 'package:invonya_mobile/core/error/failure.dart';
import 'package:invonya_mobile/core/networks/network_info.dart';
import 'package:invonya_mobile/features/data/datasources/article/article_datasource.dart';
import 'package:invonya_mobile/features/domain/entities/article.dart';
import 'package:invonya_mobile/features/domain/repositories/article_repositoty.dart';
import 'package:invonya_mobile/features/domain/usecases/get_article_topheadlines.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NetworkInfo _networkInfo;
  final ArticleRemoteDatasource _remoteDatasource;
  final ArticleLoaclDatasource _loaclDatasource;

  ArticleRepositoryImpl(
    this._networkInfo,
    this._remoteDatasource,
    this._loaclDatasource,
  );

  @override
  Stream<Either<Failure, List<Article>>> getTopHeadlines(
      GetTpoHeadlinesParams params) async* {
    if (await _networkInfo.isConnected) {
      final _result = await _remoteDatasource.getTopHeadlines(params);
      yield Right(_result);
    } else {
      final _result = await _loaclDatasource.getTopHeadlines();
      yield Right(_result);
    }
  }
}
