import '../../data/models/employee_model.dart';

abstract class EmployeeState {}

class EmployeeInitialState extends EmployeeState {}

class EmployeeLoadingState extends EmployeeState {}

class EmployeeAddedState extends EmployeeState {}

class EmployeeDeletedState extends EmployeeState {}

class EmployeeEditedState extends EmployeeState {}

class EmployeeListLoadedState extends EmployeeState {
  EmployeeListLoadedState({required this.currentEmployees, required this.previousEmployees});

  final List<Employee> currentEmployees;
  final List<Employee> previousEmployees;
}

class EmployeeErrorState extends EmployeeState {
  EmployeeErrorState({required this.message});

  final String message;
}
