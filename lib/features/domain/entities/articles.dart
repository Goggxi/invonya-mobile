import 'package:equatable/equatable.dart';
import 'package:invonya_mobile/features/domain/entities/article.dart';

class Articles extends Equatable {
  final String status;
  final int totalResults;
  final List<Article> articles;

  const Articles({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  @override
  List<Object?> get props => [status, totalResults, articles];
}
