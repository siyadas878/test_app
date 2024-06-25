import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:test_app/core/cubit/employee_cubit/employee_cubit.dart';
import 'package:test_app/core/models/employee_model.dart';
import 'package:test_app/manager/font_manager.dart';
import 'package:test_app/manager/space_manger.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  @override
  void initState() {
    BlocProvider.of<EmployeeCubit>(context).getAllEmployees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Employee List',
          style: appFont.f20w500Black,
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<EmployeeCubit, EmployeeState>(
          builder: (context, state) {
            if (state is EmployeeListingLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EmployeeListingSuccessState) {
              return ListView.separated(
                itemCount: state.employeeList.length,
                itemBuilder: (context, index) {
                  EmployeeModel employee = state.employeeList[index];
                  return InkWell(
                    onTap: () {
                      Get.toNamed('/DetailsScreen', arguments: employee);
                    },
                    child: Card(
                      child: ListTile(
                        leading: const CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
                        ),
                        title: Text(
                          employee.name ?? 'No Name',
                          style: appFont.f17w500Primary,
                        ),
                        subtitle: Text(
                            'Company: ${employee.company!.name ?? 'No Company'}'),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    appSpaces.spaceForHeight10,
              );
            } else if (state is EmployeeListingErrorState) {
              return Center(
                  child: Text(
                'Failed to load data',
                style: appFont.f17w500Primary,
              ));
            } else {
              return Center(
                  child:
                      Text('No data available', style: appFont.f17w500Primary));
            }
          },
        ),
      ),
    );
  }
}
