import 'package:dio/dio.dart';
import 'package:invonya_mobile/core/functions/static_funtion.dart';
import 'package:invonya_mobile/features/data/datasources/article/article_datasource.dart';
import 'package:invonya_mobile/features/data/models/articles_model.dart';
import 'package:invonya_mobile/features/domain/entities/article.dart';
import 'package:invonya_mobile/features/domain/usecases/get_article_topheadlines.dart';

class ArticleRemote implements ArticleRemoteDatasource {
  final Dio _dio;
  ArticleRemote(this._dio);

  static const String _topHeadlines = "top-headlines";

  @override
  Future<List<Article>> getTopHeadlines(GetTpoHeadlinesParams params) async {
    Response json = await _dio.get(
      _topHeadlines,
      queryParameters: {
        "country": params.country,
        "category": params.category,
        "pageSize": params.pageSize,
        "page": params.page,
      },
      options: StaticFunction.newsApiHttpOptions(),
    );
    return ArticlesModel.fromJson(json.data).articles;
  }
}
