import 'package:dartz/dartz.dart';
import 'package:invonya_mobile/core/error/failure.dart';
import 'package:invonya_mobile/core/networks/network_info.dart';
import 'package:invonya_mobile/features/data/datasources/article/article_datasource.dart';
import 'package:invonya_mobile/features/domain/entities/article.dart';
import 'package:invonya_mobile/features/domain/repositories/article_repositoty.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NetworkInfo _networkInfo;
  final ArticleDatasource _articleRemote;

  ArticleRepositoryImpl(this._networkInfo, this._articleRemote);

  @override
  Stream<Either<Failure, List<Article>>> getTopHeadlines() async* {
    if (await _networkInfo.isConnected) {
      final _result = await _articleRemote.getTopHeadlines();
      yield Right(_result);
    } else {
      // ! CAHCHE IMPLEMENT
    }
  }
}
