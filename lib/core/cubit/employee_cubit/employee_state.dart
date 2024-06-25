part of 'employee_cubit.dart';

abstract class EmployeeState {}

final class EmployeeInitial extends EmployeeState {}

class EmployeeListingLoadingState extends EmployeeState {}

class EmployeeListingSuccessState extends EmployeeState {
  final List<EmployeeModel> employeeList;

  EmployeeListingSuccessState({required this.employeeList});
}

class EmployeeListingErrorState extends EmployeeState {}
