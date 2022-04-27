import 'package:flutter/material.dart';
import 'package:invonya_mobile/features/domain/entities/article.dart';
import 'package:invonya_mobile/features/presentation/widgets/images.dart';

class ArticleDetailPage extends StatelessWidget {
  final Article article;
  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BuildImagePrimary(imageUrl: article.urlToImage),
          ],
        ),
      ),
    );
  }
}
