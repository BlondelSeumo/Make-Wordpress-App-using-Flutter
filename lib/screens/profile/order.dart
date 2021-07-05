import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/order/order.dart';
import 'package:cirilla/screens/order/order_detail.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/store/auth/auth_store.dart';
import 'package:cirilla/store/order/order_store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:ui/notification/notification_screen.dart';
import 'package:ui/ui.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with LoadingMixin, NavigationMixin, AppBarMixin {
  OrderStore _orderStore;
  AuthStore _authStore;

  final ScrollController _controller = ScrollController();

  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authStore = Provider.of<AuthStore>(context);
    RequestHelper requestHelper = Provider.of<RequestHelper>(context);
    _orderStore = OrderStore(
      requestHelper,
    )..getOrders(userId: _authStore.user.id);
  }

  void _onScroll() {
    if (!_controller.hasClients || _orderStore.loading || !_orderStore.canLoadMore) return;
    final thresholdReached = _controller.position.extentAfter < endReachedThreshold;

    if (thresholdReached) {
      _orderStore.getOrderNodes();
    }
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context).translate;
    return Observer(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            translate('order_return'),
            style: Theme.of(context).textTheme.subtitle1,
          ),
          shadowColor: Colors.transparent,
          centerTitle: true,
          leading: leading(),
        ),
        body: Stack(
          children: [
            if (_orderStore.orders != null)
              CustomScrollView(physics: BouncingScrollPhysics(), controller: _controller, slivers: <Widget>[
                CupertinoSliverRefreshControl(
                  onRefresh: _orderStore.refresh,
                  builder: buildAppRefreshIndicator,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      OrderData order = _orderStore.orders.elementAt(index);
                      List lineItems = order.lineItems;
                      return _buildOrderList(_orderStore, order, lineItems);
                    },
                    childCount: _orderStore.orders.length,
                  ),
                ),
              ]),
            if (_orderStore.loading && _orderStore.orders.isEmpty)
              buildLoading(context, isLoading: _orderStore.loading),
          ],
        ),
      );
    });
  }

  Widget _buildOrderList(OrderStore orderStore, OrderData order, List lineItems) {
    if (orderStore.orders.isEmpty && !orderStore.loading) {
      return _buildOrderEmpty();
    }
    TranslateType translate = AppLocalizations.of(context).translate;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: layoutPadding, vertical: 10),
      child: OrderReturnItem(
        name: Text(
          lineItems.map((e) => e.name).join(' - '),
          style: Theme.of(context).textTheme.bodyText2,
        ),
        dateTime: Text(
          formatDate(date: order.dateCreated),
          style: Theme.of(context).textTheme.caption,
        ),
        code: Text(
          'ID: #${order.id}',
          style: Theme.of(context).textTheme.caption,
        ),
        total: Text(translate('order_total'), style: Theme.of(context).textTheme.overline),
        price: Text(formatCurrency(context, currency: order.currency, price: order.total, symbol: order.currencySymbol),
            style: Theme.of(context).textTheme.subtitle1),
        onClick: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, _a1, _a2) => OrderDetailScreen(
                orderDetail: order,
              ),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                var begin = Offset(0.0, 1.0);
                var end = Offset.zero;
                var curve = Curves.ease;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
        },
        status: Badge(
          text: Text(
            order.status,
            style: Theme.of(context).textTheme.overline,
          ),
          color: order.status == 'on-hold'
              ? Color(0xFFFFA200)
              : order.status == 'processing'
                  ? Color(0xFFFFA200)
                  : order.status == 'refund'
                      ? Theme.of(context).errorColor
                      : order.status == 'successful'
                          ? Color(0xFF21BA45)
                          : Theme.of(context).errorColor,
        ),
        color: Theme.of(context).dividerColor,
      ),
    );
  }

  Widget _buildOrderEmpty() {
    TranslateType translate = AppLocalizations.of(context).translate;
    return NotificationScreen(
      title: Text(translate('order_you_have_not_order_yet'), style: Theme.of(context).textTheme.headline6),
      content:
          Text(translate('order_keep_track_of_your_orders_and_return'), style: Theme.of(context).textTheme.bodyText1),
      iconData: FeatherIcons.box,
      textButton: Text(translate('order_shopping_now')),
      onPressed: () => navigate(context, {
        "type": "tab",
        "router": "/",
        "args": {"key": "screens_category"}
      }),
    );
  }
}
