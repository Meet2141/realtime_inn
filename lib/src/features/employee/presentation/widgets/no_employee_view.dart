import 'package:flutter/material.dart';

import '../../../../core/constants/image_constants.dart';
import '../../../../core/shared/image_viewer.dart';
import '../../../../core/utils/enums.dart';

/// NoEmployeeView - Display No Employee View on Employee screen
class NoEmployeeView extends StatelessWidget {
  const NoEmployeeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ImageViewer(
        imageData: ImageData(
          type: ImageType.asset,
          src: ImageConstants.icNoData,
        ),
      ),
    );
  }
}
