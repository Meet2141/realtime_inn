import 'package:shared_preferences/shared_preferences.dart';

import '../../features/employee/data/models/employee_model.dart';

class SharedPreferencesUtils {
  static const String _employeeListKey = 'employeeList';

  // Save the list of employees to SharedPreferences
  static Future<void> saveEmployeeList(List<Employee> employeeList) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonList = employeeList.map((e) => e.toJson()).toList();
    await prefs.setStringList(_employeeListKey, jsonList);
  }

  // Load the list of employees from SharedPreferences
  static Future<List<Employee>> loadEmployeeList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList(_employeeListKey);

    if (jsonList != null) {
      // Return the list of Employee objects from the saved JSON strings
      return jsonList.map((jsonString) => Employee.fromJson(jsonString)).toList();
    }
    return []; // Return an empty list if no data exists
  }

  // Clear the saved employee list in SharedPreferences
  static Future<void> clearEmployeeList() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_employeeListKey);
  }
}
