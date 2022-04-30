import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class GetArticleTopHeadlines
    extends UseCase<List<Article>, GetTopHeadlinesParams> {
  final ArticleRepository _articleRepository;
  GetArticleTopHeadlines(this._articleRepository);

  @override
  Stream<Either<Failure, List<Article>>> build(GetTopHeadlinesParams params) {
    return _articleRepository.getTopHeadlines(params);
  }
}
