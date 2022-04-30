import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/config.dart';
import 'features.dart';
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
        theme: AppThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const PageArticleTopHeadlines(),
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
