import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

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
      GetTopHeadlinesParams params) async* {
    if (await _networkInfo.isConnected) {
      final _result = await _remoteDatasource.getTopHeadlines(params);
      yield Right(_result);
    } else {
      final _result = await _loaclDatasource.getTopHeadlines();
      yield Right(_result);
    }
  }
}
