import 'package:dio/dio.dart';
import 'package:invonya_mobile/features/data/datasources/article/article_datasource.dart';
import 'package:invonya_mobile/features/data/models/articles_model.dart';
import 'package:invonya_mobile/features/domain/entities/article.dart';

class ArticleRemote implements ArticleDatasource {
  final Dio _dio;
  ArticleRemote(this._dio);

  static const String _topHeadlines = "top-headlines";

  @override
  Future<List<Article>> getTopHeadlines() async {
    Response json = await _dio.get(_topHeadlines);
    return ArticlesModel.fromJson(json.data).articles;
  }
}
