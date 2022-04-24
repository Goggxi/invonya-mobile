import 'package:invonya_mobile/core/data/base_datasource_factory.dart';
import 'package:invonya_mobile/core/networks/network_info.dart';
import 'package:invonya_mobile/features/data/datasources/article/article_datasource_factory.dart';
import 'package:invonya_mobile/features/domain/entities/article.dart';
import 'package:invonya_mobile/features/domain/repositories/article_repositoty.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NetworkInfo _networkInfo;
  final ArticleDatasourceFactory _articleDatasourceFactory;

  ArticleRepositoryImpl(this._networkInfo, this._articleDatasourceFactory);

  @override
  Stream<List<Article>> getTopHeadlines() async* {
    if (await _networkInfo.isConnected) {
      final _result = await _articleDatasourceFactory
          .createData(DataSourceState.network)
          .getTopHeadlines();
      yield _result;
    } else {
      final _result = await _articleDatasourceFactory
          .createData(DataSourceState.local)
          .getTopHeadlines();
      yield _result;
    }
  }
}
