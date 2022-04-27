import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invonya_mobile/features/presentation/blocs/get_article_topheadlines/get_article_topheadlines_cubit.dart';
import 'package:invonya_mobile/features/presentation/blocs/get_article_topheadlines_category/get_article_topheadlines_category_cubit.dart';
import 'package:invonya_mobile/features/presentation/pages/top_headlines/top_headlines_page.dart';

import 'injector.dart';

class InvonyaApp extends StatelessWidget {
  const InvonyaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<GetArticleTopheadlinesCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<GetArticleTopheadlinesCategoryCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Invonya',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TopHeadlinesPage(),
      ),
    );
  }
}
