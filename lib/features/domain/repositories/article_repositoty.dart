import '../entities/article.dart';

abstract class ArticleRepository {
  Stream<List<Article>> getTopHeadlines();
}
