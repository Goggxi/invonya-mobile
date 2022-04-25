import 'package:invonya_mobile/features/domain/entities/article.dart';
import 'package:invonya_mobile/features/domain/usecases/get_article_topheadlines.dart';

abstract class ArticleRemoteDatasource {
  Future<List<Article>> getTopHeadlines(GetTpoHeadlinesParams params);
}

abstract class ArticleLoaclDatasource {
  Future<List<Article>> getTopHeadlines();
}
