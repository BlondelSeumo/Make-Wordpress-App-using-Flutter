import 'dart:async';
import 'dart:io';

import 'package:cirilla/mixins/loading_mixin.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  static const routeName = '/web_view';

  final Map args;

  const WebViewScreen({Key key, this.args}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> with LoadingMixin {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.args['name'] ?? ''),
      ),
      body: widget.args != null && widget.args['url'] == null
          ? Container()
          : Stack(
              children: [
                WebView(
                  initialUrl: widget.args['url'],
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                  onProgress: (int progress) {
                    print("WebView is loading (progress : $progress%)");
                  },
                  navigationDelegate: (NavigationRequest request) {
                    print('allowing navigation to $request');
                    return NavigationDecision.navigate;
                  },
                  onPageStarted: (String url) {
                    print('Page started loading: $url');
                  },
                  onPageFinished: (String url) {
                    setState(() {
                      _loading = false;
                    });
                  },
                  gestureNavigationEnabled: true,
                ),
                if (_loading) buildLoading(context, isLoading: _loading),
              ],
            ),
    );
  }
}
