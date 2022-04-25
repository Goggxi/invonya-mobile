import 'dart:convert';

import 'package:invonya_mobile/features/domain/entities/source.dart';

SourceModel sourceModelFromJson(String str) =>
    SourceModel.fromJson(json.decode(str));

String sourceModelToJson(SourceModel data) => json.encode(data.toJson());

class SourceModel extends Source {
  const SourceModel({
    final dynamic id,
    final String? name,
    final String? description,
    final String? url,
    final String? category,
    final String? language,
    final String? country,
  }) : super(
          id: id ?? "",
          name: name ?? "",
          description: description ?? "",
          url: url ?? "",
          category: category ?? "",
          language: language ?? "",
          country: country ?? "",
        );

  factory SourceModel.fromEntity(Source source) => SourceModel(
        id: source.id,
        name: source.name,
        description: source.description,
        url: source.url,
        category: source.category,
        language: source.language,
        country: source.category,
      );

  Source toEntity() {
    return Source(
      id: id,
      name: name,
      description: description,
      url: url,
      category: category,
      language: language,
      country: country,
    );
  }

  factory SourceModel.fromJson(Map<String, dynamic> json) => SourceModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        url: json["url"],
        category: json["category"],
        language: json["language"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "url": url,
        "category": category,
        "language": language,
        "country": country,
      };
}
