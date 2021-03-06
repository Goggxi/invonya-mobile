import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/core.dart';
import '../../../domain/entities/entites.dart';
import '../../presentation.dart';
import 'widgets/widgets.dart';

class PageArticleTopHeadlines extends StatelessWidget {
  const PageArticleTopHeadlines({Key? key}) : super(key: key);

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
                  return InkWell(
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: SvgPicture.asset(
                            countries[index].image,
                            height: 24,
                            width: 34,
                            semanticsLabel: 'image-flags',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(countries[index].name),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(__);
                      __
                          .read<GetArticleTopheadlinesCubit>()
                          .getTopHeadlines(true, countries[index].id);
                    },
                  );
                },
                // separatorBuilder: (_, __) => const SizedBox(height: 0),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: _buildAppBar(context, () => _showListCounties()),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context, void Function() onPressed) {
    return AppBar(
      title: Text(
        "Invonya",
        style: TextStyle(
          fontFamily: "Lobster",
          fontSize: 26,
          color: Theme.of(context).primaryColor,
        ),
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Row(
            children: [
              BlocBuilder<GetArticleTopheadlinesCubit,
                  GetArticleTopheadlinesState>(
                builder: (context, state) {
                  String _country = '';
                  if (state is GetArticleTopheadlinesWaiting) {
                    _country = state.country;
                  } else if (state is GetArticleTopheadlinesLoaded) {
                    _country = state.country;
                  }

                  return _country.isEmpty
                      ? Container()
                      : Row(
                          children: [
                            const Icon(Icons.arrow_drop_down_rounded),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: SvgPicture.asset(
                                "assets/images/$_country.svg",
                                height: 24,
                                width: 34,
                                semanticsLabel: 'image-flags',
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        );
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildBody() {
    return BlocBuilder<GetArticleTopheadlinesCubit,
        GetArticleTopheadlinesState>(
      builder: (context, state) {
        String _country = '';
        if (state is GetArticleTopheadlinesWaiting) {
          _country = state.country;
        } else if (state is GetArticleTopheadlinesLoaded) {
          _country = state.country;
        }
        return _buildPagingArticle(context, _country);
      },
    );
  }

  Widget _buildPagingArticle(BuildContext context, String country) {
    return WidgetPaging(
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

        if (state is GetArticleTopheadlinesInitial) {
          return const Center(
            child: Text("INITIAL"),
          );
        } else if (state is GetArticleTopheadlinesReset) {
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

  CustomScrollView _buildCustomScrollView(
    List<Article> articles,
    String country,
  ) {
    return CustomScrollView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        _buildTitle("Kategori"),
        _buildListCategory(country),
        _buildTitle("Sedang Trending"),
        _buildListArticle(articles),
      ],
    );
  }

  SliverToBoxAdapter _buildTitle(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: "Lobster",
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildListCategory(String country) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 120,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _buildCardItemCategory(context, categories[index], country);
          },
          separatorBuilder: (context, index) => Container(),
          itemCount: categories.length,
        ),
      ),
    );
  }

  Card _buildCardItemCategory(
    BuildContext context,
    Category category,
    String country,
  ) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return PageArticleTopHeadlinesCategory(
                category: category,
                country: country,
              );
            },
          ));
        },
        child: Stack(
          children: [
            Image.asset(
              category.image,
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 120,
                padding: const EdgeInsets.symmetric(vertical: 6),
                color: Colors.black38,
                child: Text(
                  category.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: AppColors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverList _buildListArticle(List<Article> articles) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return WidgetArticleItem(
            article: articles[index],
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return PageArticleDetail(article: articles[index]);
                },
              ));
            },
          );
        },
        childCount: articles.length,
      ),
    );
  }
}
