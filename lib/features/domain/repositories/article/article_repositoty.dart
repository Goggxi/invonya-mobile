import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../domain.dart';

abstract class ArticleRepository {
  Stream<Either<Failure, List<Article>>> getTopHeadlines(
    GetTopHeadlinesParams params,
  );
}
