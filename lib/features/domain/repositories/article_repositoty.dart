import 'package:dartz/dartz.dart';
import 'package:invonya_mobile/core/error/failure.dart';
import 'package:invonya_mobile/features/domain/usecases/get_article_topheadlines.dart';

import '../entities/article.dart';

abstract class ArticleRepository {
  Stream<Either<Failure, List<Article>>> getTopHeadlines(GetTpoHeadlinesParams params);
}
