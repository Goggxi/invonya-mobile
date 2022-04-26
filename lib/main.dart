import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:invonya_mobile/features/presentation/blocs/get_article_topheadlines/get_article_topheadlines_cubit.dart';
import 'package:invonya_mobile/features/presentation/pages/top_headlines/top_headlines_page.dart';
import 'features/injector.dart' as di;
import 'features/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  await dotenv.load();
  await di.init();
  runApp(const InvonyaApp());
}

class InvonyaApp extends StatelessWidget {
  const InvonyaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GetArticleTopheadlinesCubit>(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TopHeadlinesPage(),
      ),
    );
  }
}
