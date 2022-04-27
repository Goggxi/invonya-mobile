import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invonya_mobile/core/data/article_support_categories.dart';
import 'package:invonya_mobile/features/presentation/blocs/get_article_topheadlines_category/get_article_topheadlines_category_cubit.dart';
import 'package:invonya_mobile/features/presentation/widgets/images.dart';

import '../../../domain/entities/article.dart';
import '../../widgets/smartrefresher.dart';

class TopHeadlinesCategoryPage extends StatelessWidget {
  final Category category;
  final String country;
  const TopHeadlinesCategoryPage({
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
      body: _buildPagingArticle(context),
    );
  }

  Widget _buildPagingArticle(BuildContext context) {
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
        final data = articles[index];
        return Column(
          children: [
            BuildImagePrimary(imageUrl: data.urlToImage),
            Text(data.source.name),
          ],
        );
      },
      separatorBuilder: (context, index) => Container(),
      itemCount: articles.length,
    );
  }
}
