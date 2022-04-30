import '../../../features.dart';

class ArticleModel extends Article {
  ArticleModel({
    SourceModel? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    DateTime? publishedAt,
    String? content,
  }) : super(
          source: source!.toEntity(),
          author: author ?? "",
          title: title ?? "",
          description: description ?? "",
          url: url ?? "",
          urlToImage: urlToImage ?? "",
          publishedAt: publishedAt ?? DateTime.now(),
          content: content ?? "",
        );

  factory ArticleModel.formEntity(Article article) => ArticleModel(
        source: SourceModel.fromEntity(article.source),
        author: article.author,
        title: article.title,
        description: article.description,
        url: article.url,
        urlToImage: article.urlToImage,
        publishedAt: article.publishedAt,
        content: article.content,
      );

  Article toEntity() {
    return Article(
      source: source,
      author: author,
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
    );
  }

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        source: SourceModel.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "source": SourceModel.fromEntity(source).toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
      };
}
