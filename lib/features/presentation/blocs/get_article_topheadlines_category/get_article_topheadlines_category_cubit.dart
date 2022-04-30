import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/core.dart';
import '../../../domain/domain.dart';


part 'get_article_topheadlines_category_state.dart';

class GetArticleTopheadlinesCategoryCubit
    extends Cubit<GetArticleTopheadlinesCategoryState> {
  final RefreshController pagingCtrl = RefreshController(initialRefresh: true);
  final GetArticleTopHeadlines _articleTopHeadlines;
  int _page = 0;

  GetArticleTopheadlinesCategoryCubit(this._articleTopHeadlines)
      : super(GetArticleTopheadlinesCategoryInitial());

  void getTopHeadlinesWithCategory(
    bool onRefresh,
    String country,
    String category,
  ) {
    final _currentState = state;

    if (onRefresh) {
      pagingCtrl.resetNoData();
      _page = 1;
    } else {
      _page++;
    }

    final params = GetTopHeadlinesParams(
      country: country.isNotEmpty ? country : "id",
      category: category,
      pageSize: "10",
      page: _page.toString(),
    );

    var _oldPosts = <Article>[];
    if (_currentState is GetArticleTopheadlinesCategoryLoaded) {
      _oldPosts = _currentState.articles;
    }

    emit(GetArticleTopheadlinesCategoryWaiting(_oldPosts));

    if (onRefresh) {
      emit(GetArticleTopheadlinesCategoryReset());
    }
    _articleTopHeadlines.execute(params).listen((event) {
      event.fold(
        (failure) {
          if (onRefresh) {
            log("FAILURE ARTICLE REFRESH -> " + failure.message);
            emit(GetArticleTopheadlinesCategoryError());
            return pagingCtrl.refreshFailed();
          } else {
            log("FAILURE ARTICLE NEXT -> " + failure.message);
            emit(GetArticleTopheadlinesCategoryError());
            pagingCtrl.loadFailed();
            return pagingCtrl.loadNoData();
          }
        },
        (response) {
          if (onRefresh) {
            emit(GetArticleTopheadlinesCategoryLoaded(response));
            return pagingCtrl.refreshCompleted();
          } else {
            if (response.isEmpty) {
              return pagingCtrl.loadNoData();
            } else {
              final _articles =
                  (state as GetArticleTopheadlinesCategoryWaiting).articles;
              _articles.addAll(response);
              emit(GetArticleTopheadlinesCategoryLoaded(_articles));
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
