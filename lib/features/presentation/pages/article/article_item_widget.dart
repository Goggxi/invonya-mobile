import 'package:flutter/material.dart';
import 'package:invonya_mobile/core/functions/extension_function.dart';
import 'package:invonya_mobile/features/domain/entities/article.dart';

import '../../../../core/utils/colors.dart';
import '../../widgets/images.dart';

class BuildArticleItem extends StatelessWidget {
  final Article article;
  final void Function() onTap;
  const BuildArticleItem({Key? key, required this.article, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildImagePrimary(
              imageUrl: article.urlToImage,
              width: MediaQuery.of(context).size.width,
              radius: 12,
            ),
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
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.orange,
                              ),
                        ),
                      ],
                    ),
                  ),
            article.source.name.isEmpty
                ? Container()
                : const SizedBox(height: 10),
            article.title.isEmpty
                ? Container()
                : Text(
                    article.title,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
            const SizedBox(height: 10),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
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
                          Text(
                            article.author,
                            style: Theme.of(context).textTheme.caption,
                          ),
                          const SizedBox(width: 12),
                        ],
                      ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(height: 0, thickness: 0.8),
          ],
        ),
      ),
    );
  }
}
