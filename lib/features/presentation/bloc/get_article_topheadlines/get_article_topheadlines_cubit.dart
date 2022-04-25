import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invonya_mobile/features/domain/entities/article.dart';
import 'package:invonya_mobile/features/domain/usecases/get_article_topheadlines.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'get_article_topheadlines_state.dart';

class GetArticleTopheadlinesCubit extends Cubit<GetArticleTopheadlinesState> {
  final RefreshController pagingCtrl = RefreshController(initialRefresh: true);
  final GetArticleTopHeadlines _articleTopHeadlines;
  int _page = 0;

  GetArticleTopheadlinesCubit(this._articleTopHeadlines)
      : super(GetArticleTopheadlinesInitial());

  void getTopHeadlines(bool onRefresh) {
    final _currentState = state;

    if (onRefresh) {
      pagingCtrl.resetNoData();
      _page = 1;
    } else {
      _page++;
    }

    final params = GetTpoHeadlinesParams(
      country: "id",
      pageSize: "10",
      page: _page.toString(),
    );

    var _oldPosts = <Article>[];
    if (_currentState is GetArticleTopheadlinesLoaded) {
      _oldPosts = _currentState.articles;
    }

    emit(GetArticleTopheadlinesWaiting(_oldPosts));

    _articleTopHeadlines.execute(params).listen((event) {
      event.fold(
        (failure) {
          if (onRefresh) {
            log("FAILURE BLOC R -> " + failure.message);
            emit(GetArticleTopheadlinesError());
            return pagingCtrl.refreshFailed();
          } else {
            log("FAILURE BLOC N -> " + failure.message);
            emit(GetArticleTopheadlinesError());
            pagingCtrl.loadFailed();
            return pagingCtrl.loadNoData();
          }
        },
        (response) {
          if (onRefresh) {
            emit(GetArticleTopheadlinesLoaded(response));
            return pagingCtrl.refreshCompleted();
          } else {
            if (response.isEmpty) {
              return pagingCtrl.loadNoData();
            } else {
              final _articles =
                  (state as GetArticleTopheadlinesWaiting).articles;
              _articles.addAll(response);
              emit(GetArticleTopheadlinesLoaded(_articles));
              return pagingCtrl.loadComplete();
            }
          }
        },
      );
    });
  }

  @override
  Future<void> close() {
    pagingCtrl.dispose();
    return super.close();
  }
}
