import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BuildWebView extends StatefulWidget {
  final String url;
  const BuildWebView({Key? key, required this.url}) : super(key: key);

  @override
  State<BuildWebView> createState() => _BuildWebViewState();
}

class _BuildWebViewState extends State<BuildWebView> {
  int _progress = 0;

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invonya"),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            gestureNavigationEnabled: true,
            debuggingEnabled: true,
            onProgress: (i) {
              setState(() {
                _progress = i;
              });
            },
          ),
          _progress < 100 ? const CircularProgressIndicator() : const SizedBox()
        ],
      ),
    );
  }
}
