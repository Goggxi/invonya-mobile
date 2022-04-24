import 'package:invonya_mobile/core/data/base_datasource_factory.dart';
import 'package:invonya_mobile/features/data/datasources/article/article_datasource.dart';

import 'article_cache.dart';
import 'article_remote.dart';

class ArticleDatasourceFactory
    extends BaseDatasourceFactory<ArticleDatasource> {
  final ArticleCache _articleCache;
  final ArticleRemote _articleRemote;

  ArticleDatasourceFactory(
    this._articleCache,
    this._articleRemote,
  );

  @override
  ArticleDatasource createData(DataSourceState dataSourceState) {
    switch (dataSourceState) {
      case DataSourceState.network:
        return _articleRemote;
      case DataSourceState.local:
        return _articleCache;
      default:
        throw UnsupportedError("Datasource $dataSourceState is not support");
    }
  }
}
