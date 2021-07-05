import 'package:cirilla/store/auth/auth_store.dart';
import 'package:cirilla/store/wishlist/wishlist_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin WishListMixin<T extends StatefulWidget> on State<T> {
  bool loading = false;

  WishListStore _wishListStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _wishListStore = Provider.of<AuthStore>(context).wishListStore;
  }

  Future<void> addWishList({int productId}) async {
    setState(() {
      loading = true;
    });
    try {
      await _wishListStore.addWishList(productId.toString());
      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      throw e;
    }
  }

  bool existWishList({int productId}) {
    return _wishListStore.exist(productId.toString());
  }
}
