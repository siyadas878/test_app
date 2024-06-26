import 'package:bloc/bloc.dart';
import 'package:test_app/core/models/employee_model.dart';
import 'package:test_app/core/repository/employee_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final EmployeeRepo employeeRepo;
  SearchCubit({required this.employeeRepo}) : super(SearchInitialState());
  void searchEmployees(String query) async {
    if (query.isEmpty) {
      emit(SearchInitialState());
      return;
    }

    emit(SearchLoadingState());
    try {
      final allEmployees = await employeeRepo.getEmployeesFromHive();
      final results = allEmployees!.where((employee) {
        final nameLower = employee.name?.toLowerCase() ?? '';
        final emailLower = employee.email?.toLowerCase() ?? '';
        final searchLower = query.toLowerCase();

        return nameLower.contains(searchLower) ||
            emailLower.contains(searchLower);
      }).toList();

      emit(SearchSuccessState(employeeList: results));
    } catch (e) {
      emit(SearchErrorState());
    }
  }
}
