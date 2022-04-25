import 'package:equatable/equatable.dart';
import 'package:invonya_mobile/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:invonya_mobile/core/usecases/usecase.dart';
import 'package:invonya_mobile/features/domain/entities/article.dart';
import 'package:invonya_mobile/features/domain/repositories/article_repositoty.dart';

class GetArticleTopHeadlines extends UseCase<List<Article>, GetTpoHeadlinesParams> {
  final ArticleRepository _articleRepository;
  GetArticleTopHeadlines(this._articleRepository);

  @override
  Stream<Either<Failure, List<Article>>> build(GetTpoHeadlinesParams params) {
    return _articleRepository.getTopHeadlines(params);
  }
}

class GetTpoHeadlinesParams extends Equatable{
  final String country;
  final String pageSize;
  final String page;

  const GetTpoHeadlinesParams({
    required this.country,
    required this.pageSize,
    required this.page,
  });

  @override
  List<Object?> get props => [country, pageSize, page];
}

