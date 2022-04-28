import 'package:flutter/material.dart';
import 'package:invonya_mobile/config/theme/app_themes.dart';
import 'package:invonya_mobile/core/functions/extension_function.dart';
import 'package:invonya_mobile/features/domain/entities/article.dart';
import 'package:invonya_mobile/features/presentation/widgets/images.dart';

import '../../../../core/utils/colors.dart';

class ArticleDetailPage extends StatelessWidget {
  final Article article;
  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppThemes.lightTheme.copyWith(dividerColor: Colors.transparent),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Detail berita"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.bookmark_outline, color: Colors.black54),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BuildImagePrimary(imageUrl: article.urlToImage),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    article.source.name.isEmpty
                        ? Container()
                        : Text.rich(
                            TextSpan(
                              text: "Sumber : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(fontWeight: FontWeight.w100),
                              children: [
                                TextSpan(
                                  text: article.source.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.orange,
                                      ),
                                ),
                              ],
                            ),
                          ),
                    const SizedBox(height: 10),
                    Text(article.title,
                        style: Theme.of(context).textTheme.headline6),
                    const SizedBox(height: 10),
                    Wrap(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.today_rounded),
                            const SizedBox(width: 2),
                            Text(
                              article.publishedAt.toCustomFormat,
                              style: Theme.of(context).textTheme.caption,
                            ),
                            const SizedBox(width: 12),
                          ],
                        ),
                        article.author.isEmpty
                            ? Container()
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.account_circle_rounded),
                                  const SizedBox(width: 2),
                                  Flexible(
                                    child: Text(
                                      article.author,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                ],
                              ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      article.description,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(article.content,
                        style: Theme.of(context).textTheme.bodyText2),
                  ],
                ),
              ),
            ],
          ),
        ),
        persistentFooterButtons: [
          SizedBox(
            height: 42,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Baca selengkapnya"),
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
