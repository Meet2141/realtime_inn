import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

/// HorizontalDivider - Display Horizontal Divider
class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({
    super.key,
    this.height = 1.0,
    this.dividerColor,
  });

  final double height;
  final Color? dividerColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: dividerColor ?? ColorConstants.secondary,
    );
  }
}
