import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/shared_pref_utils.dart';
import '../../data/models/employee_model.dart';
import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitialState()) {
    on<AddEmployeeEvent>(_onAddEmployee);
    on<EditEmployeeEvent>(_onEditEmployee);
    on<FetchEmployeeListEvent>(_onFetchEmployeeList);
    on<DeleteEmployeeEvent>(_onDeleteEmployee);
  }

  List<Employee> employeeList = [];

  Future<void> _onAddEmployee(AddEmployeeEvent event, Emitter<EmployeeState> emit) async {
    try {
      employeeList.add(event.employee);
      await SharedPreferencesUtils.saveEmployeeList(employeeList);
      add(FetchEmployeeListEvent());
      emit(EmployeeAddedState());
    } catch (e) {
      emit(EmployeeErrorState(message: 'Failed to add employee.'));
    }
  }

  Future<void> _onEditEmployee(EditEmployeeEvent event, Emitter<EmployeeState> emit) async {
    try {
      final index = employeeList.indexWhere((e) => e.id == event.employee.id);
      if (index != -1) {
        employeeList[index] = event.employee;
        await SharedPreferencesUtils.saveEmployeeList(employeeList);
        add(FetchEmployeeListEvent());
        emit(EmployeeEditedState());
      } else {
        emit(EmployeeErrorState(message: 'Employee not found.'));
      }
    } catch (e) {
      emit(EmployeeErrorState(message: 'Failed to edit employee.'));
    }
  }

  Future<void> _onFetchEmployeeList(FetchEmployeeListEvent event, Emitter<EmployeeState> emit) async {
    try {
      employeeList = await SharedPreferencesUtils.loadEmployeeList();

      List<Employee> currentEmployees = [];
      List<Employee> previousEmployees = [];
      DateTime now = DateTime.now();

      for (var employee in employeeList) {
        if (employee.endDate == null || employee.endDate!.isAfter(now)) {
          currentEmployees.add(employee);
        } else {
          previousEmployees.add(employee);
        }
      }

      emit(EmployeeListLoadedState(
        currentEmployees: currentEmployees,
        previousEmployees: previousEmployees,
      ));
    } catch (e) {
      emit(EmployeeErrorState(message: 'Failed to fetch employee list.'));
    }
  }

  Future<void> _onDeleteEmployee(DeleteEmployeeEvent event, Emitter<EmployeeState> emit) async {
    try {
      employeeList.remove(event.employee);
      await SharedPreferencesUtils.saveEmployeeList(employeeList);
      add(FetchEmployeeListEvent());
      emit(EmployeeDeletedState());
    } catch (e) {
      emit(EmployeeErrorState(message: 'Failed to delete employee.'));
    }
  }
}
