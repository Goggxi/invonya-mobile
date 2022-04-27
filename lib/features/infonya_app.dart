import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invonya_mobile/config/theme/app_themes.dart';
import 'package:invonya_mobile/features/presentation/blocs/get_article_topheadlines/get_article_topheadlines_cubit.dart';
import 'package:invonya_mobile/features/presentation/blocs/get_article_topheadlines_category/get_article_topheadlines_category_cubit.dart';

import 'injector.dart';
import 'presentation/pages/article/article_top_headlines_page.dart';

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
        theme: AppThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const ArticleTopHeadlinesPage(),
        supportedLocales: const [Locale('id', 'ID')],
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
      ),
    );
  }
}
