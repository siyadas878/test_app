import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/core/models/employee_model.dart';
import 'package:test_app/widgets/custom_snackBar.dart';

class EmployeeRepo {
  Future<void> getAllEmployees() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        List<EmployeeModel> employeeList =
            jsonResponse.map((data) => EmployeeModel.fromJson(data)).toList();

        var box = await Hive.openBox<EmployeeModel>('employeeBox');
        await box.clear();
        await box.addAll(employeeList);
      } else {
        // customSnackBar(title: 'Error', message: 'Somthing went wrong');
        if (kDebugMode) {
          print('Error ------------${response.body}');
        }
      }
    } catch (e) {
      // customSnackBar(title: 'Error', message: 'Somthing went wrong');
      log(e.toString());
    }
  }

  Future<List<EmployeeModel>?> getEmployeesFromHive() async {
    var box = await Hive.openBox<EmployeeModel>('employeeBox');
    return box.values.toList();
  }
}
