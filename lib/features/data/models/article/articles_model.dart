import 'dart:convert';

import '../../../features.dart';

ArticlesModel articlesModelFromJson(String str) =>
    ArticlesModel.fromJson(json.decode(str));

String articlesModelToJson(ArticlesModel data) => json.encode(data.toJson());

class ArticlesModel extends Articles {
  ArticlesModel({
    final String? status,
    final int? totalResults,
    final List<ArticleModel>? articles,
  }) : super(
          status: status ?? "",
          totalResults: totalResults ?? 0,
          articles: articles!.map((e) => e.toEntity()).toList(),
        );

  factory ArticlesModel.fromJson(Map<String, dynamic> json) => ArticlesModel(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<ArticleModel>.from(
            json["articles"].map((x) => ArticleModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(
          articles.map(
            (x) => ArticleModel.formEntity(x).toJson(),
          ),
        ),
      };
}
