import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WidgetPaging extends StatelessWidget {
  final RefreshController controller;
  final void Function() onRefresh;
  final void Function() onLoading;
  final Widget child;
  const WidgetPaging({
    Key? key,
    required this.controller,
    required this.onRefresh,
    required this.onLoading,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller,
      enablePullUp: true,
      enablePullDown: true,
      onRefresh: onRefresh,
      onLoading: onLoading,
      physics: const BouncingScrollPhysics(),
      footer: CustomFooter(
        builder: (context, mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const Text("Lepaskan untuk meumuat aktivitas");
          } else if (mode == LoadStatus.loading) {
            body = const SizedBox(
              height: 22,
              width: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
              ),
            );
          } else if (mode == LoadStatus.failed) {
            body = const Text("Pemuatan gagal! Klik coba lagi!");
          } else if (mode == LoadStatus.canLoading) {
            body = const Text("Lepaskan untuk memuat lebih banyak");
          } else {
            body = const Text("...");
          }
          return Center(child: body);
        },
      ),
      child: child,
    );
  }
}
