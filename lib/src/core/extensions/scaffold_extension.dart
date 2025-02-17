import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

/// ScaffoldExtension class return scaffold widget with fixed layout properties.
/// Created to maintain same layout properties in whole application.
extension ScaffoldExtension on Widget {
  PopScope baseScaffold({
    bool? resizeToAvoidBottomInset,
    double? horizontalPadding = 16,
    PreferredSizeWidget? appBar,
    Color? backgroundColor,
  }) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: appBar,
        backgroundColor: backgroundColor ?? ColorConstants.white,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: Column(
          children: [
            // Stack(
            //   children: [
            //     const BackGroundImageWidgets(height: 40),
            //     AppBarWidgets(
            //       title: title,
            //       onTap: onTap,
            //     ),
            //   ],
            // ),
            bodyPadding(
              horizontalPadding: horizontalPadding,
            ),
          ],
        ),
      ),
    );
  }

  PopScope baseScaffoldNoAppBar({
    Color? backgroundColor,
    double? horizontalPadding,
  }) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: backgroundColor ?? ColorConstants.white,
        body: bodyPadding(
          horizontalPadding: horizontalPadding,
        ),
      ),
    );
  }

  Widget bodyPaddingWithExpanded({double? horizontalPadding}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 16),
        child: this,
      ),
    );
  }

  Widget bodyPadding({double? horizontalPadding}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 16),
      child: this,
    );
  }

  Widget bodyPaddingSymmetric({double? horizontal, double? vertical}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal ?? 16, vertical: vertical ?? 16),
      child: this,
    );
  }
}
