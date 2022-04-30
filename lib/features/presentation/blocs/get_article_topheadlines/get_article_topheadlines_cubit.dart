import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/core.dart';
import '../../../domain/domain.dart';

part 'get_article_topheadlines_state.dart';

class GetArticleTopheadlinesCubit extends Cubit<GetArticleTopheadlinesState> {
  final RefreshController pagingCtrl = RefreshController(initialRefresh: true);
  final GetArticleTopHeadlines _articleTopHeadlines;
  int _page = 0;

  GetArticleTopheadlinesCubit(this._articleTopHeadlines)
      : super(GetArticleTopheadlinesInitial());

  void getTopHeadlines(bool onRefresh, String country) {
    final _currentState = state;
    final _paramsCountry = country.isNotEmpty ? country : "id";

    if (onRefresh) {
      pagingCtrl.resetNoData();
      _page = 1;
    } else {
      _page++;
    }

    final params = GetTopHeadlinesParams(
      country: _paramsCountry,
      category: "general",
      pageSize: "10",
      page: _page.toString(),
    );

    var _oldPosts = <Article>[];
    var _oldCountry = _paramsCountry;
    if (_currentState is GetArticleTopheadlinesLoaded) {
      _oldPosts = _currentState.articles;
      _oldCountry = _currentState.country;
    }

    emit(GetArticleTopheadlinesWaiting(_oldPosts, _oldCountry));

    if (onRefresh) {
      emit(GetArticleTopheadlinesReset());
    }
    _articleTopHeadlines.execute(params).listen((event) {
      event.fold(
        (failure) {
          if (onRefresh) {
            log("FAILURE ARTICLE REFRESH -> " + failure.message);
            emit(GetArticleTopheadlinesError());
            return pagingCtrl.refreshFailed();
          } else {
            log("FAILURE ARTICLE NEXT -> " + failure.message);
            emit(GetArticleTopheadlinesError());
            pagingCtrl.loadFailed();
            return pagingCtrl.loadNoData();
          }
        },
        (response) {
          if (onRefresh) {
            emit(GetArticleTopheadlinesLoaded(response, _paramsCountry));
            return pagingCtrl.refreshCompleted();
          } else {
            if (response.isEmpty) {
              return pagingCtrl.loadNoData();
            } else {
              final _articles =
                  (state as GetArticleTopheadlinesWaiting).articles;
              _articles.addAll(response);
              emit(GetArticleTopheadlinesLoaded(_articles, _paramsCountry));
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
