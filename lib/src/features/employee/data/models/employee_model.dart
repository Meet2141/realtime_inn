import 'dart:convert';
import 'dart:math';

class Employee {
  // Convert a JSON string to an Employee object
  factory Employee.fromJson(String source) {
    final map = jsonDecode(source);
    return Employee(
      id: map['id'],
      name: map['name'],
      role: map['role'],
      startDate: DateTime.parse(map['startDate']),
      endDate: map['endDate'] != null ? DateTime.parse(map['endDate']) : null,
    );
  }
  Employee({
    String? id,
    required this.name,
    required this.role,
    required this.startDate,
    this.endDate,
  }) : id = id ?? generateId();

  final String id;
  final String name;
  final String role;
  final DateTime startDate;
  final DateTime? endDate;

  // Generate a unique ID (or you could implement your own logic)
  static String generateId() {
    return Random().nextInt(1000000).toString();
  }

  // Convert an Employee object to a map that can be easily converted to JSON
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
    };
  }

  // Convert an Employee object to a JSON string
  String toJson() => jsonEncode(toMap());
}
