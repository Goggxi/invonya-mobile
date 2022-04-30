import 'package:dio/dio.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class ArticleRemote implements ArticleRemoteDatasource {
  final Dio _dio;
  ArticleRemote(this._dio);

  static const String _topHeadlines = "top-headlines";

  @override
  Future<List<Article>> getTopHeadlines(GetTopHeadlinesParams params) async {
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
