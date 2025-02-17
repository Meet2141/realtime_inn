import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/routing_constants.dart';
import '../../../../core/constants/size_constants.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/extensions/gesture_extensions.dart';
import '../../../../core/shared/image_viewer.dart';
import '../../../../core/utils/bottom_sheet_utils.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../core/widgets/textfield/primary_input_text.dart';
import '../../../employee/data/models/employee_model.dart';
import '../../../employee/presentation/bloc/employee_bloc.dart';
import '../../../employee/presentation/bloc/employee_event.dart';
import '../../../employee/presentation/bloc/employee_state.dart';
import 'add_employee_actions.dart';
import 'add_employee_bottomsheet_view.dart';

/// AddEmployeeForm - Display Add Employee Form in Add Employee Screen
class AddEmployeeForm extends StatefulWidget {
  const AddEmployeeForm({
    super.key,
    required this.employee,
  });

  final Employee employee;

  @override
  State<AddEmployeeForm> createState() => _AddEmployeeFormState();
}

class _AddEmployeeFormState extends State<AddEmployeeForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    if (widget.employee.id.isNotEmpty) {
      _nameController.text = widget.employee.name;
      _roleController.text = widget.employee.role;
      _startDate = widget.employee.startDate;
      _endDate = widget.employee.endDate;
      _startDateController.text = DateFormat(StringConstants.defaultDate).format(_startDate!);
      if (_endDate != null) {
        _endDateController.text = DateFormat(StringConstants.defaultDate).format(_endDate!);
      }
    } else {
      _setInitialStartDate();
    }
  }

  void _setInitialStartDate() {
    _startDate = DateTime.now();
    _startDateController.text = StringConstants.today;
  }

  void _updateStartDate(DateTime pickedDate) {
    setState(() {
      _startDate = pickedDate;
      final today = DateTime.now();
      _startDateController.text = (_startDate!.isAtSameMomentAs(today))
          ? StringConstants.today
          : DateFormat(StringConstants.defaultDate).format(_startDate!);

      if (_endDate != null && _endDate!.isBefore(_startDate!)) {
        _endDate = null;
        _endDateController.clear();
      }
    });
  }

  Future<void> _selectDate({required bool isStartDate}) async {
    DateTime initialDate = isStartDate ? _startDate! : (_endDate ?? _startDate!.add(const Duration(days: 1)));

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: isStartDate ? DateTime(2000) : _startDate!.add(const Duration(days: 1)),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      if (isStartDate) {
        _updateStartDate(pickedDate);
      } else {
        setState(() {
          _endDate = pickedDate;
          _endDateController.text = DateFormat(StringConstants.defaultDate).format(_endDate!);
        });
      }
    }
  }

  void _saveEmployee() {
    if (!_validateForm()) return;

    Employee newEmployee = Employee(
      id: widget.employee.id.isNotEmpty ? widget.employee.id : Employee.generateId(),
      name: _nameController.text,
      role: _roleController.text,
      startDate: _startDate!,
      endDate: _endDate,
    );

    if (widget.employee.id.isNotEmpty) {
      context.read<EmployeeBloc>().add(EditEmployeeEvent(employee: newEmployee));
    } else {
      context.read<EmployeeBloc>().add(AddEmployeeEvent(employee: newEmployee));
    }
  }

  bool _validateForm() {
    if (_nameController.text.isEmpty) {
      ToastUtils.showFailed(message: StringConstants.nameIsRequired);
      return false;
    } else if (_roleController.text.isEmpty) {
      ToastUtils.showFailed(message: StringConstants.roleIsRequired);
      return false;
    } else if (_endDate != null && _endDate!.isBefore(_startDate!)) {
      ToastUtils.showFailed(message: StringConstants.endDateError);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bottomInset = mediaQuery.viewInsets.bottom;
    final isKeyboardOpen = bottomInset > 0;

    return BlocListener<EmployeeBloc, EmployeeState>(
      listener: (context, state) {
        if (state is EmployeeAddedState) {
          ToastUtils.showSuccess(message: StringConstants.employeeAddedSuccess);
          context.goNamed(RoutingConstants.employee);
        } else if (state is EmployeeEditedState) {
          ToastUtils.showSuccess(message: StringConstants.employeeUpdatedSuccess);
          context.goNamed(RoutingConstants.employee);
        } else if (state is EmployeeErrorState) {
          ToastUtils.showFailed(message: StringConstants.employeeAddError);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: isKeyboardOpen ? bottomInset : 16,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              vSpace(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildInputField(
                        controller: _nameController,
                        hintText: StringConstants.employeeName,
                        icon: Icons.person_2_outlined,
                      ),
                      vSpace(),
                      _buildInputField(
                        controller: _roleController,
                        hintText: StringConstants.selectRole,
                        icon: Icons.work_outline,
                        readOnly: true,
                        suffixIcon: Icons.arrow_drop_down,
                        onTap: () {
                          BottomSheetUtils.showCustomBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return AddEmployeeBottomSheetView(
                                onTap: (value) {
                                  _roleController.text = value;
                                },
                              );
                            },
                          );
                        },
                      ),
                      vSpace(),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDatePickerField(
                              controller: _startDateController,
                              hintText: StringConstants.startDate,
                              icon: Icons.calendar_today,
                              isStartDate: true,
                            ),
                          ),
                          hSpace(8),
                          ImageViewer(
                            imageData: ImageData(
                              type: ImageType.icon,
                              iconData: Icons.arrow_forward,
                            ),
                            color: ColorConstants.primary,
                          ),
                          hSpace(8),
                          Expanded(
                            child: _buildDatePickerField(
                              controller: _endDateController,
                              hintText: StringConstants.endDate,
                              icon: Icons.calendar_today,
                              isStartDate: false,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              AddEmployeeActions(
                onTap: _saveEmployee,
              ),
            ],
          ),
        ),
      ),
    ).onPressedWithoutHaptic(() {
      FocusScope.of(context).unfocus();
    });
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool readOnly = false,
    IconData? suffixIcon,
    GestureTapCallback? onTap,
  }) {
    return PrimaryInputText(
      hintText: hintText,
      controller: controller,
      onChanged: (value) {},
      prefixIcon: Icon(
        icon,
        color: ColorConstants.primary,
      ),
      readOnly: readOnly,
      suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: ColorConstants.primary) : null,
      onTap: onTap,
    );
  }

  Widget _buildDatePickerField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required bool isStartDate,
  }) {
    return PrimaryInputText(
      hintText: hintText,
      controller: controller,
      readOnly: true,
      onChanged: (value) {},
      prefixIcon: Icon(
        icon,
        color: ColorConstants.primary,
      ),
      onTap: () => _selectDate(isStartDate: isStartDate),
    );
  }
}
