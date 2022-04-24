import 'package:invonya_mobile/features/data/datasources/article/article_datasource.dart';
import 'package:invonya_mobile/features/domain/entities/article.dart';

class ArticleCache implements ArticleDatasource {
  @override
  Future<List<Article>> getTopHeadlines() {
    throw UnimplementedError();
  }
}
