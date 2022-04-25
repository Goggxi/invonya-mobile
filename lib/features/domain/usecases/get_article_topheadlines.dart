import 'package:invonya_mobile/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:invonya_mobile/core/usecases/usecase.dart';
import 'package:invonya_mobile/features/domain/entities/article.dart';
import 'package:invonya_mobile/features/domain/repositories/article_repositoty.dart';

class GetArticleTopHeadlines extends UseCase<List<Article>, NoParams> {
  final ArticleRepository _articleRepository;
  GetArticleTopHeadlines(this._articleRepository);

  @override
  Stream<Either<Failure, List<Article>>> build(NoParams params) {
    return _articleRepository.getTopHeadlines();
  }
}
