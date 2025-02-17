import '../../data/models/employee_model.dart';

abstract class EmployeeEvent {}

class AddEmployeeEvent extends EmployeeEvent {
  AddEmployeeEvent({required this.employee});

  final Employee employee;
}

class EditEmployeeEvent extends EmployeeEvent {
  EditEmployeeEvent({required this.employee});

  final Employee employee;
}

class FetchEmployeeListEvent extends EmployeeEvent {}

class DeleteEmployeeEvent extends EmployeeEvent {
  DeleteEmployeeEvent({required this.employee});

  final Employee employee;
}
