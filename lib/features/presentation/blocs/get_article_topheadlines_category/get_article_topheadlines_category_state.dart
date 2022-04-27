part of 'get_article_topheadlines_category_cubit.dart';

abstract class GetArticleTopheadlinesCategoryState extends Equatable {
  const GetArticleTopheadlinesCategoryState();

  @override
  List<Object> get props => [];
}

class GetArticleTopheadlinesCategoryInitial
    extends GetArticleTopheadlinesCategoryState {}

class GetArticleTopheadlinesCategoryLoaded
    extends GetArticleTopheadlinesCategoryState {
  final List<Article> articles;

  const GetArticleTopheadlinesCategoryLoaded(this.articles);

  @override
  List<Object> get props => [articles];
}

class GetArticleTopheadlinesCategoryWaiting
    extends GetArticleTopheadlinesCategoryState {
  final List<Article> articles;

  const GetArticleTopheadlinesCategoryWaiting(
    this.articles,
  );

  @override
  List<Object> get props => [articles];
}

class GetArticleTopheadlinesCategoryReset
    extends GetArticleTopheadlinesCategoryState {}

class GetArticleTopheadlinesCategoryError
    extends GetArticleTopheadlinesCategoryState {}
