import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/routing_constants.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/extensions/gesture_extensions.dart';
import '../../../core/shared/image_viewer.dart';
import '../../../core/shared/text_widgets.dart';
import '../../../core/utils/enums.dart';
import '../../../core/utils/toast_utils.dart';
import '../../employee/data/models/employee_model.dart';
import '../../employee/presentation/bloc/employee_bloc.dart';
import '../../employee/presentation/bloc/employee_event.dart';
import '../../employee/presentation/bloc/employee_state.dart';
import 'widgets/add_employee_form.dart';

/// AddEmployeeScreen - Display Add Employee Screen
class AddEmployeeScreen extends StatelessWidget {
  const AddEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Employee? employee = GoRouterState.of(context).extra as Employee?;
    return BlocListener<EmployeeBloc, EmployeeState>(
      listener: (context, state) {
        if (state is EmployeeDeletedState) {
          ToastUtils.showSuccess(message: StringConstants.employeeDeletedSuccess);
          context.goNamed(RoutingConstants.employee);
        } else if (state is EmployeeErrorState) {
          ToastUtils.showFailed(message: StringConstants.employeeDeleteError);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorConstants.primary,
          leading: const SizedBox.shrink(),
          title: TextWidgets(
            text:
                (employee?.id ?? '').isEmpty ? StringConstants.addEmployeeDetails : StringConstants.editEmployeeDetails,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: ColorConstants.white,
            ),
          ),
          actions: [
            if ((employee?.id ?? '').isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ImageViewer(
                  imageData: ImageData(
                    type: ImageType.icon,
                    iconData: Icons.delete,
                  ),
                  color: ColorConstants.white,
                ).onPressedWithHaptic(() {
                  context.read<EmployeeBloc>().add(
                        DeleteEmployeeEvent(
                          employee: employee ??
                              Employee(
                                id: '',
                                name: '',
                                role: '',
                                startDate: DateTime.now(),
                              ),
                        ),
                      );
                }),
              ),
          ],
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
      ),
    );
  }
}
