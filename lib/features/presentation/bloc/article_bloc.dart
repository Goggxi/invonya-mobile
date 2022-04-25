import 'dart:developer';

import 'package:invonya_mobile/core/usecases/usecase.dart';
import 'package:invonya_mobile/features/domain/entities/article.dart';
import 'package:invonya_mobile/features/domain/usecases/get_article_topheadlines.dart';
import 'package:rxdart/rxdart.dart';

class ArticleBloc {
  final GetArticleTopHeadlines _getArticleTopHeadlines;

  ArticleBloc(this._getArticleTopHeadlines);

  final _topHeadlines = BehaviorSubject<List<Article>>();

  Stream<List<Article>> get streamTopHeadlines => _topHeadlines.stream;

  void fetchTopHeadlines() {
    _getArticleTopHeadlines.execute(NoParams()).listen((event) {
      event.fold(
        (failure) => log(failure.message),
        (response) => _topHeadlines.add(response),
      );
    });
  }

  void dispose() => _topHeadlines.close();
}
