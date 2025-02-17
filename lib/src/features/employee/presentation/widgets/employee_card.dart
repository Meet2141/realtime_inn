import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/routing_constants.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/shared/text_widgets.dart';
import '../../../../core/widgets/divider/horizontal_divider.dart';
import '../../data/models/employee_model.dart';
import '../bloc/employee_bloc.dart';
import '../bloc/employee_event.dart';

/// EmployeeCard - Display Employee Card view on Employee screen
class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    super.key,
    required this.title,
    required this.employees,
  });

  final String title;
  final List<Employee> employees;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextWidgets(
            text: title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorConstants.primary,
            ),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: employees.length,
          separatorBuilder: (c, i) {
            return const HorizontalDivider();
          },
          itemBuilder: (c, i) {
            return Slidable(
              key: UniqueKey(),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      context.pushNamed(
                        RoutingConstants.addEmployee,
                        extra: employees[i],
                      );
                    },
                    backgroundColor: ColorConstants.grey[400]!,
                    foregroundColor: ColorConstants.white,
                    icon: Icons.edit,
                    label: StringConstants.edit,
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      context.read<EmployeeBloc>().add(DeleteEmployeeEvent(employee: employees[i]));
                    },
                    backgroundColor: ColorConstants.red,
                    foregroundColor: ColorConstants.white,
                    icon: Icons.delete,
                    label: StringConstants.delete,
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                child: ColoredBox(
                  color: ColorConstants.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextWidgets(
                            text: employees[i].name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                          child: TextWidgets(
                            text: employees[i].role,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: ColorConstants.textColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextWidgets(
                            text: employees[i].endDate != null
                                ? '${convertDate(employees[i].startDate.toString())} - ${convertDate(employees[i].endDate.toString())}'
                                : 'From ${convertDate(employees[i].startDate.toString())}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: ColorConstants.textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  String convertDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat(StringConstants.newDate).format(dateTime);
  }
}
