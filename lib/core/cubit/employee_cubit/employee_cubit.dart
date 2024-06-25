import 'package:bloc/bloc.dart';
import 'package:test_app/core/models/employee_model.dart';
import 'package:test_app/core/repository/employee_repo.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeRepo employeeRepo;
  EmployeeCubit({required this.employeeRepo}) : super(EmployeeInitial());

  getAllEmployees() async {
    emit(EmployeeListingLoadingState());
    try {
      final hiveEmployee = await employeeRepo.getEmployeesFromHive();
      emit(EmployeeListingSuccessState(employeeList: hiveEmployee ?? []));
    } catch (e) {
      emit(EmployeeListingErrorState());
    }
  }
}
