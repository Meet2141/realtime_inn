import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/shared/text_widgets.dart';
import 'bloc/employee_bloc.dart';
import 'bloc/employee_event.dart';
import 'bloc/employee_state.dart';
import 'widgets/employee_action_view.dart';
import 'widgets/employee_card.dart';
import 'widgets/no_employee_view.dart';

/// EmployeeScreen - Display Employee List Screen
class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EmployeeBloc>().add(FetchEmployeeListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.secondary,
      appBar: AppBar(
        title: const TextWidgets(
          text: StringConstants.employeeList,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: ColorConstants.white,
          ),
        ),
        backgroundColor: ColorConstants.primary,
      ),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is EmployeeListLoadedState) {
            if (state.currentEmployees.isEmpty && state.previousEmployees.isEmpty) {
              return const NoEmployeeView();
            }
            return ListView(
              shrinkWrap: true,
              children: [
                if (state.currentEmployees.isNotEmpty)
                  EmployeeCard(
                    title: StringConstants.currentEmployee,
                    employees: state.currentEmployees,
                  ),
                if (state.previousEmployees.isNotEmpty)
                  EmployeeCard(
                    title: StringConstants.previousEmployee,
                    employees: state.previousEmployees,
                  ),
              ],
            );
          } else if (state is EmployeeErrorState) {
            return Center(
                child: TextWidgets(
              text: state.message,
              style: const TextStyle(),
            ));
          }
          return const NoEmployeeView();
        },
      ),
      floatingActionButton: const EmployeeActionView(),
    );
  }
}
