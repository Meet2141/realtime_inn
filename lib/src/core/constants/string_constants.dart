import '../app_state/app_state.dart';

typedef JsonPayLoad = Map<String, dynamic>;

/// Global variable for AppState class
AppState appState = AppState();

/// StringConstants contains all constant string used in app.
class StringConstants {
  static const appName = 'Realtime Innovations';
  static const developerName = 'Meet Shah';
  static const by = 'by';
  static const home = 'Home';
  static const welcome = 'Welcome!';
  static const cancel = 'Cancel';
  static const yes = 'Yes';
  static const no = 'No';
  static const ok = 'Ok';
  static const save = 'Save';
  static const selectRole = 'Select Role';
  static const startDate = 'Start Date';
  static const endDate = 'End Date';
  static const today = 'Today';
  static const noDate = 'No Date';
  static const employeeName = 'Employee Name';
  static const employeeList = 'Employee List';
  static const addEmployeeDetails = 'Add Employee Details';
  static const editEmployeeDetails = 'Edit Employee Details';
  static const copiedToClipBoard = 'Copied to Clipboard!';
  static const employeeAddedSuccess = 'Employee added successfully!';
  static const employeeUpdatedSuccess = 'Employee updated successfully!';
  static const defaultDate = 'dd/MM/yyyy';
  static const newDate = 'd MMM, yyyy';
  static const delete = 'Delete';
  static const edit = 'Edit';
  static const currentEmployee = 'Current employees';
  static const previousEmployee = 'Previous employees';

  //Error
  static const requestTimedOut = 'Request timed out';
  static const serverError = 'Server error';
  static const somethingWentWrong = 'Something went wrong!';
  static const connectTimedOut = 'Connect timed out';
  static const pleaseTryAgain = 'Please try again.';
  static const employeeAddError = 'Employee adding error!';
  static const nameIsRequired = 'Employee name is required!!';
  static const roleIsRequired = 'Employee role is required!!';
  static const pleaseCheckInternet = 'Please Check Internet';
  static const endDateError = 'End date must be after Start date!';
  static const internetConnectionLost = 'Internet connection lost. Please retry';
  static const errorMessage = 'Authentication failed, Please contact to admin for onBoarding!';
}
