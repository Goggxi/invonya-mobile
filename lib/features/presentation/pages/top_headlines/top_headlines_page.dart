import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invonya_mobile/core/data/article_support_countries.dart';
import 'package:invonya_mobile/features/presentation/widgets/images.dart';

import '../../../domain/entities/article.dart';
import '../../blocs/get_article_topheadlines/get_article_topheadlines_cubit.dart';
import '../../widgets/smartrefresher.dart';

class TopHeadlinesPage extends StatelessWidget {
  const TopHeadlinesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showListCounties(BuildContext context) {
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
        title: const Text("Top Headline"),
        actions: [
          TextButton(
            onPressed: () => _showListCounties(context),
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
      child: _buildStateArticle(),
      controller: context.read<GetArticleTopheadlinesCubit>().pagingCtrl,
      onRefresh: () => context
          .read<GetArticleTopheadlinesCubit>()
          .getTopHeadlines(true, country),
      onLoading: () => context
          .read<GetArticleTopheadlinesCubit>()
          .getTopHeadlines(false, country),
    );
  }

  Widget _buildStateArticle() {
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

        return _buildListArticle(articles);
      },
    );
  }

  Widget _buildListArticle(List<Article> articles) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 12),
      itemBuilder: (context, index) {
        final data = articles[index];
        return Column(
          children: [
            BuildImagePrimary(imageUrl: data.urlToImage),
            Text(data.source.name),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      itemCount: articles.length,
    );
  }
}
