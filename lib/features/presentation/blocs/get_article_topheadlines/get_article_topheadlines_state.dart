part of 'get_article_topheadlines_cubit.dart';

abstract class GetArticleTopheadlinesState extends Equatable {
  const GetArticleTopheadlinesState();

  @override
  List<Object> get props => [];
}

class GetArticleTopheadlinesInitial extends GetArticleTopheadlinesState {}

class GetArticleTopheadlinesLoaded extends GetArticleTopheadlinesState {
  final List<Article> articles;
  final String country;

  const GetArticleTopheadlinesLoaded(this.articles, this.country);

  @override
  List<Object> get props => [articles, country];
}

class GetArticleTopheadlinesWaiting extends GetArticleTopheadlinesState {
  final List<Article> articles;
  final String country;

  const GetArticleTopheadlinesWaiting(
    this.articles,
    this.country,
  );

  @override
  List<Object> get props => [articles, country];
}

class GetArticleTopheadlinesReset extends GetArticleTopheadlinesState {}

class GetArticleTopheadlinesError extends GetArticleTopheadlinesState {}
