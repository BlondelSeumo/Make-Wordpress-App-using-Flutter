import 'dart:async';
import 'dart:io';
import 'package:cirilla/mixins/loading_mixin.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/screens/checkout/order_received.dart';
import 'package:cirilla/store/cart/cart_store.dart';
import 'package:cirilla/store/setting/setting_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> with LoadingMixin, TransitionMixin {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  bool _loading = true;
  SettingStore _settingStore;
  CartStore _cartStore;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void didChangeDependencies() {
    _settingStore = Provider.of<SettingStore>(context);
    _cartStore = Provider.of<CartStore>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      Map<String, String> queryParams = {
        'cart_key_restore': _cartStore.cartKey,
        'app-builder-css': 'true',
        'id-selector': 'main',
      };

      String url = _settingStore.checkoutUrl + '?' + Uri(queryParameters: queryParams).query;

      print(url);

      return Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
        ),
        body: Builder(builder: (BuildContext context) {
          return Stack(
            children: [
              WebView(
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                onProgress: (int progress) {
                  print("WebView is loading (progress : $progress%)");
                },
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.contains('/order-received/')) {
                    Navigator.of(context).pushReplacement(PageRouteBuilder(
                      pageBuilder: (context, _a1, _a2) => OrderReceived(),
                      transitionsBuilder: slideTransition,
                    ));
                  }

                  if (request.url.contains('/cart/')) {
                    Navigator.of(context).pop();
                    return NavigationDecision.prevent;
                  }

                  if (request.url.contains('/my-account/')) {
                    return NavigationDecision.prevent;
                  }

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
          );
        }),
      );
    });
  }
}
