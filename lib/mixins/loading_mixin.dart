import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// Define loading mixin
///
abstract class LoadingMixin {
  // Used in scroll section when user scroll down to load more data
  Widget buildAppRefreshIndicator(
    BuildContext context,
    RefreshIndicatorMode refreshState,
    double pulledExtent,
    double refreshTriggerPullDistance,
    double refreshIndicatorExtent,
  ) {
    const Curve opacityCurve = const Interval(0.4, 0.8, curve: Curves.easeInOut);
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.only(top: 24.0),
        child: refreshState == RefreshIndicatorMode.drag
            ? Opacity(
                opacity: opacityCurve.transform(min(pulledExtent / refreshTriggerPullDistance, 1.0)),
                child: const Icon(
                  Icons.arrow_downward,
                  color: CupertinoColors.inactiveGray,
                  size: 24.0,
                ),
              )
            : Opacity(
                opacity: opacityCurve.transform(min(pulledExtent / refreshIndicatorExtent, 1.0)),
                child: SpinKitThreeBounce(
                  color: Theme.of(context).primaryColor,
                  size: 30.0,
                ),
              ),
      ),
    );
  }

  // Used in every child widget need loading state
  Widget buildLoading(BuildContext context, {bool isLoading = false}) {
    return isLoading
        ? Container(
            padding: EdgeInsets.only(bottom: 20),
            alignment: Alignment.center,
            child: SpinKitThreeBounce(
              color: Theme.of(context).primaryColor,
              size: 30.0,
            ),
          )
        : SizedBox();
  }

  Widget buildLoadingOverlay(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: SpinKitThreeBounce(
        color: Theme.of(context).colorScheme.onPrimary,
        size: 30.0,
      ),
    );
  }

  Widget entryLoading(BuildContext context, {double size = 16, Color color}) {
    return SpinKitThreeBounce(
      color: color ?? Theme.of(context).primaryColor,
      size: size,
    );
  }
}
