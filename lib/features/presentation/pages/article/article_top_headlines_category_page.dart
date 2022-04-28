import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invonya_mobile/core/data/article_support_categories.dart';
import 'package:invonya_mobile/features/presentation/blocs/get_article_topheadlines_category/get_article_topheadlines_category_cubit.dart';

import '../../../domain/entities/article.dart';
import '../../widgets/smartrefresher.dart';
import 'article_detail_page.dart';
import 'article_item_widget.dart';

class ArticleTopHeadlinesCategoryPage extends StatelessWidget {
  final Category category;
  final String country;
  const ArticleTopHeadlinesCategoryPage({
    Key? key,
    required this.category,
    required this.country,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BuildSmartRefresher(
      child: _buildStateArticle(),
      controller:
          context.read<GetArticleTopheadlinesCategoryCubit>().pagingCtrl,
      onRefresh: () => context
          .read<GetArticleTopheadlinesCategoryCubit>()
          .getTopHeadlinesWithCategory(true, country, category.id),
      onLoading: () => context
          .read<GetArticleTopheadlinesCategoryCubit>()
          .getTopHeadlinesWithCategory(false, country, category.id),
    );
  }

  Widget _buildStateArticle() {
    return BlocBuilder<GetArticleTopheadlinesCategoryCubit,
        GetArticleTopheadlinesCategoryState>(
      builder: (context, state) {
        List<Article> articles = [];

        if (state is GetArticleTopheadlinesCategoryReset) {
          articles.clear();
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetArticleTopheadlinesCategoryWaiting) {
          articles = state.articles;
        } else if (state is GetArticleTopheadlinesCategoryLoaded) {
          articles = state.articles;
        } else if (state is GetArticleTopheadlinesCategoryError) {
          return const Center(
            child: Text("ERROR"),
          );
        }

        return _buildListArticle(articles);
      },
    );
  }

  Widget _buildListArticle(List<Article> articles) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return BuildArticleItem(
          article: articles[index],
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ArticleDetailPage(article: articles[index]);
              },
            ));
          },
        );
      },
      separatorBuilder: (context, index) => Container(),
      itemCount: articles.length,
    );
  }
}
