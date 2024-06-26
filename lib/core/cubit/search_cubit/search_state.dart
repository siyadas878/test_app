part of 'search_cubit.dart';

abstract class SearchState {}

//search states

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  final List<EmployeeModel> employeeList;

  SearchSuccessState({required this.employeeList});
}

class SearchErrorState extends SearchState {}
