part of 'get_article_topheadlines_cubit.dart';

abstract class GetArticleTopheadlinesState extends Equatable {
  const GetArticleTopheadlinesState();

  @override
  List<Object> get props => [];
}

class GetArticleTopheadlinesInitial extends GetArticleTopheadlinesState {}

class GetArticleTopheadlinesLoaded extends GetArticleTopheadlinesState {
  final List<Article> articles;

  const GetArticleTopheadlinesLoaded(this.articles);

  @override
  List<Object> get props => [articles];
}

class GetArticleTopheadlinesWaiting extends GetArticleTopheadlinesState {
  final List<Article> articles;
  final bool isFirstFetch;

  const GetArticleTopheadlinesWaiting(
    this.articles, {
    this.isFirstFetch = false,
  });

  @override
  List<Object> get props => [articles];
}

class GetArticleTopheadlinesError extends GetArticleTopheadlinesState {}
