import 'package:invonya_mobile/features/domain/entities/article.dart';

abstract class ArticleDatasource {
  Future<List<Article>> getTopHeadlines();
}
