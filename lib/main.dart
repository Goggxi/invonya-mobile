import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:invonya_mobile/features/presentation/bloc/get_article_topheadlines/get_article_topheadlines_cubit.dart';
import 'package:invonya_mobile/features/presentation/widget/smartrefresher.dart';
import 'features/domain/entities/article.dart';
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
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GetArticleTopheadlinesCubit>(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final _getArticleTopHeadlines = sl<GetArticleTopHeadlines>();
  // final List<Article> _articles = [];
  // final _refreshController = RefreshController(initialRefresh: true);
  // int _page = 1;

  // void refreshTopHeadlines() {
  //   _refreshController.resetNoData();
  //   _articles.clear();
  //   _page = 1;
  //   final params = GetTpoHeadlinesParams(
  //     country: "id",
  //     pageSize: "7",
  //     page: _page.toString(),
  //   );
  //   _getArticleTopHeadlines.execute(params).listen((event) {
  //     event.fold(
  //       (failure) {
  //         log(failure.message);
  //         return _refreshController.refreshFailed();
  //       },
  //       (response) {
  //         setState(() {
  //           _articles.addAll(response);
  //         });
  //         return _refreshController.refreshCompleted();
  //       },
  //     );
  //   });
  // }

  // void nextTopHeadlines() {
  //   _page++;
  //   final params = GetTpoHeadlinesParams(
  //     country: "id",
  //     pageSize: "7",
  //     page: _page.toString(),
  //   );
  //   _getArticleTopHeadlines.execute(params).listen((event) {
  //     event.fold(
  //       (failure) {
  //         log(failure.message);
  //         return _refreshController.loadFailed();
  //       },
  //       (response) {
  //         if (response.isEmpty) {
  //           return _refreshController.loadNoData();
  //         }
  //         setState(() {
  //           _articles.addAll(response);
  //         });
  //         return _refreshController.loadComplete();
  //       },
  //     );
  //   });
  // }

  // @override
  // void dispose() {
  //   _refreshController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BuildSmartRefresher(
        child: _buildStateArticle(),
        controller: context.read<GetArticleTopheadlinesCubit>().pagingCtrl,
        onRefresh: () =>
            context.read<GetArticleTopheadlinesCubit>().getTopHeadlines(true),
        onLoading: () =>
            context.read<GetArticleTopheadlinesCubit>().getTopHeadlines(false),
      ),
    );
  }

  Widget _buildStateArticle() {
    return BlocBuilder<GetArticleTopheadlinesCubit,
        GetArticleTopheadlinesState>(
      builder: (context, state) {
        List<Article> articles = [];

        if (state is GetArticleTopheadlinesWaiting) {
          articles = state.articles;
        } else if (state is GetArticleTopheadlinesLoaded) {
          articles = state.articles;
        } else if (state is GetArticleTopheadlinesError) {
          return const Center(
            child: Text("ERROR"),
          );
        }

        return _buildScrollView(articles);
      },
    );
  }

  Widget _buildScrollView(List<Article> articles) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 12),
      itemBuilder: (context, index) {
        final data = articles[index];
        return Column(
          children: [
            Image.network(data.urlToImage),
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
