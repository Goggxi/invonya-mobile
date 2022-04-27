import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invonya_mobile/core/data/article_support_categories.dart';
import 'package:invonya_mobile/core/data/article_support_countries.dart';
import 'package:invonya_mobile/features/presentation/pages/top_headlines/top_headlines_category_page.dart';
import 'package:invonya_mobile/features/presentation/widgets/images.dart';

import '../../../domain/entities/article.dart';
import '../../blocs/get_article_topheadlines/get_article_topheadlines_cubit.dart';
import '../../widgets/smartrefresher.dart';

class TopHeadlinesPage extends StatelessWidget {
  const TopHeadlinesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showListCounties() {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Pilih Negara'),
            content: SizedBox(
              width: double.minPositive,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: countries.length,
                itemBuilder: (__, index) {
                  return ListTile(
                    title: Text(countries[index].name),
                    onTap: () {
                      Navigator.pop(__);
                      __
                          .read<GetArticleTopheadlinesCubit>()
                          .getTopHeadlines(true, countries[index].id);
                    },
                  );
                },
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Invonya"),
        actions: [
          TextButton(
            onPressed: () => _showListCounties(),
            child: Row(
              children: [
                const Icon(Icons.arrow_drop_down_rounded),
                BlocBuilder<GetArticleTopheadlinesCubit,
                    GetArticleTopheadlinesState>(
                  builder: (context, state) {
                    String _country = '';
                    if (state is GetArticleTopheadlinesWaiting) {
                      _country = state.country;
                    } else if (state is GetArticleTopheadlinesLoaded) {
                      _country = state.country;
                    }
                    return Text(_country);
                  },
                ),
              ],
            ),
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
          )
        ],
      ),
      body:
          BlocBuilder<GetArticleTopheadlinesCubit, GetArticleTopheadlinesState>(
        builder: (context, state) {
          String _country = '';
          if (state is GetArticleTopheadlinesWaiting) {
            _country = state.country;
          } else if (state is GetArticleTopheadlinesLoaded) {
            _country = state.country;
          }
          return _buildPagingArticle(context, _country);
        },
      ),
    );
  }

  Widget _buildPagingArticle(BuildContext context, String country) {
    return BuildSmartRefresher(
      child: _buildStateArticle(country),
      controller: context.read<GetArticleTopheadlinesCubit>().pagingCtrl,
      onRefresh: () => context
          .read<GetArticleTopheadlinesCubit>()
          .getTopHeadlines(true, country),
      onLoading: () => context
          .read<GetArticleTopheadlinesCubit>()
          .getTopHeadlines(false, country),
    );
  }

  Widget _buildStateArticle(String country) {
    return BlocBuilder<GetArticleTopheadlinesCubit,
        GetArticleTopheadlinesState>(
      builder: (context, state) {
        List<Article> articles = [];

        if (state is GetArticleTopheadlinesReset) {
          articles.clear();
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetArticleTopheadlinesWaiting) {
          articles = state.articles;
        } else if (state is GetArticleTopheadlinesLoaded) {
          articles = state.articles;
        } else if (state is GetArticleTopheadlinesError) {
          return const Center(
            child: Text("ERROR"),
          );
        }

        return _buildCustomScrollView(articles, country);
      },
    );
  }

  Widget _buildCustomScrollView(List<Article> articles, String country) {
    return CustomScrollView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        _buildListCategory(country),
        _buildListArticle(articles),
      ],
    );
  }

  Widget _buildListCategory(String country) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 72,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final data = categories[index];
            return Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return TopHeadlinesCategoryPage(
                        category: data,
                        country: country,
                      );
                    },
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(data.iconData),
                      const Spacer(),
                      Text(data.name),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => Container(),
          itemCount: categories.length,
        ),
      ),
    );
  }

  Widget _buildListArticle(List<Article> articles) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final data = articles[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                BuildImagePrimary(imageUrl: data.urlToImage),
                Text(data.source.name),
              ],
            ),
          );
        },
        childCount: articles.length,
      ),
    );
  }
}
