import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/extensions/gesture_extensions.dart';
import '../../../core/shared/image_viewer.dart';
import '../../../core/shared/text_widgets.dart';
import '../../../core/utils/enums.dart';
import '../../employee/data/models/employee_model.dart';
import 'widgets/add_employee_form.dart';

/// AddEmployeeScreen - Display Add Employee Screen
class AddEmployeeScreen extends StatelessWidget {
  const AddEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Employee? employee = GoRouterState.of(context).extra as Employee?;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: false,
        leading: ImageViewer(
          imageData: ImageData(
            type: ImageType.icon,
            iconData: Icons.arrow_back,
          ),
          color: ColorConstants.white,
        ).onPressedWithHaptic(() {
          context.pop();
        }),
        title: TextWidgets(
          text: (employee?.id ?? '').isEmpty ? StringConstants.addEmployeeDetails : StringConstants.editEmployeeDetails,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: ColorConstants.white,
          ),
        ),
        backgroundColor: ColorConstants.primary,
      ),
      body: AddEmployeeForm(
        employee: employee ??
            Employee(
              id: '',
              name: '',
              role: '',
              startDate: DateTime.now(),
            ),
      ),
    );
  }
}
