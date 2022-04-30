import '../../../../core/core.dart';
import '../../../features.dart';

abstract class ArticleRemoteDatasource {
  Future<List<Article>> getTopHeadlines(GetTopHeadlinesParams params);
}

abstract class ArticleLoaclDatasource {
  Future<List<Article>> getTopHeadlines();
}
