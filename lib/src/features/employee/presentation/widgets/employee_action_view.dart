import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/image_constants.dart';
import '../../../../core/constants/routing_constants.dart';
import '../../../../core/extensions/gesture_extensions.dart';
import '../../../../core/shared/image_viewer.dart';
import '../../../../core/utils/enums.dart';
import '../../data/models/employee_model.dart';

/// EmployeeActionView - Display Add action on Employee screen
class EmployeeActionView extends StatelessWidget {
  const EmployeeActionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: ColorConstants.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ImageViewer(
        imageData: ImageData(
          type: ImageType.asset,
          src: ImageConstants.icAdd,
        ),
      ),
    ).onPressedWithHaptic(() {
      context.pushNamed(
        RoutingConstants.addEmployee,
        extra: Employee(
          id: '',
          name: '',
          role: '',
          startDate: DateTime.now(),
        ),
      );
    });
  }
}
