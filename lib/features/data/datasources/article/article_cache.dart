import '../../../features.dart';

class ArticleCache implements ArticleLoaclDatasource {
  @override
  Future<List<Article>> getTopHeadlines() {
    throw UnimplementedError();
  }
}
