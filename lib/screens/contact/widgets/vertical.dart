import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/app_bar_mixin.dart';
import 'package:cirilla/mixins/utility_mixin.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'horizontal.dart';

class VerticalContact extends StatefulWidget {
  /// customize items
  final List items;

  /// enable icon direction map
  final bool enableDirectMap;

  /// widget MapView
  final Widget mapView;

  /// widget FloatingActionButtonLocation
  final Widget buttonLocation;

  final Function(double lat, double lng, double bearing, double tilt, double zoom) gotoMarker;

  final String languageKey;

  const VerticalContact({
    Key key,
    @required this.items,
    @required this.mapView,
    @required this.gotoMarker,
    this.enableDirectMap = true,
    this.buttonLocation,
    this.languageKey = 'text',
  }) : super(key: key);

  @override
  _VerticalContact createState() => _VerticalContact();
}

class _VerticalContact extends State<VerticalContact> with Utility, AppBarMixin {
  double top = 0.7;

  void goAddress(dynamic item) {
    double lat = ConvertData.stringToDouble(get(item, ['data', 'lat'], initlat), initlat);
    double lng = ConvertData.stringToDouble(get(item, ['data', 'lng'], initlng), initlng);
    double bearing = ConvertData.stringToDouble(get(item, ['data', 'bearing'], enableBearing), enableBearing);
    double tilt = ConvertData.stringToDouble(get(item, ['data', 'tilt'], enableTilt), enableTilt);
    double zoom = ConvertData.stringToDouble(get(item, ['data', 'zoom'], enableZoom), enableZoom);
    widget.gotoMarker(lat, lng, bearing, tilt, zoom);
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context).translate;
    ThemeData theme = Theme.of(context);
    double screenHeight = MediaQuery.of(context).size.height - 90;
    double width = MediaQuery.of(context).size.width;
    int count = widget.items.length;

    return Scaffold(
      extendBody: true,
      appBar: baseStyleAppBar(context, title: translate('contact_us')),
      body: Stack(
        children: [
          widget.mapView ?? Container(),
          NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              setState(() {
                top = 1 - notification.extent;
              });
              return true;
            },
            child: DraggableScrollableActuator(
              child: DraggableScrollableSheet(
                expand: true,
                initialChildSize: 0.3,
                minChildSize: 0.3,
                maxChildSize: 0.85,
                builder: (
                  BuildContext context,
                  ScrollController scrollController,
                ) {
                  return Container(
                    color: theme.scaffoldBackgroundColor,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Column(
                        children: List.generate(widget.items.length, (index) {
                          dynamic item = widget.items.elementAt(index);

                          // info
                          String heading = get(item, ['data', 'titleHeading', widget.languageKey], '');

                          EdgeInsetsDirectional padding =
                              EdgeInsetsDirectional.only(bottom: index < count - 1 ? 40 : 0);

                          return Padding(
                            padding: padding,
                            child: ContactContainedItem(
                              headOffice: Text(heading, style: theme.textTheme.headline6),
                              directionMap: widget.enableDirectMap
                                  ? InkWell(
                                      onTap: () => goAddress(item),
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        width: 34,
                                        height: 34,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: theme.primaryColor),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        alignment: Alignment.center,
                                        child: Icon(FeatherIcons.cornerUpRight, size: 14, color: theme.primaryColor),
                                      ),
                                    )
                                  : null,
                              description: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1, color: theme.dividerColor),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Info(item: item, languageKey: widget.languageKey, pad: 8, goAddress: goAddress),
                              ),
                              width: width - 40,
                            ),
                          );
                        }),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          if (widget.buttonLocation is Widget)
            Positioned(
              top: screenHeight * top - 70,
              right: 24.0,
              child: SizedBox(
                height: 48,
                width: 48,
                child: widget.buttonLocation,
              ),
            ),
          Positioned(
            top: screenHeight * top + 8,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
                height: 4,
                width: 60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
