import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:test_app/core/cubit/employee_cubit/employee_cubit.dart';
import 'package:test_app/core/cubit/search_cubit/search_cubit.dart';
import 'package:test_app/core/models/employee_model.dart';
import 'package:test_app/manager/font_manager.dart';
import 'package:test_app/manager/space_manger.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<EmployeeCubit>(context).getAllEmployees();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Employee List',
            style: appFont.f20w500Black,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide()),
                    labelText: '  Search Employee',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        context
                            .read<SearchCubit>()
                            .searchEmployees(_searchController.text);
                      },
                    ),
                  ),
                  onChanged: (value) {
                    context.read<SearchCubit>().searchEmployees(value);
                  },
                ),
              ),
              Expanded(
                child: BlocBuilder<EmployeeCubit, EmployeeState>(
                  builder: (context, state) {
                    if (state is EmployeeListingLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is EmployeeListingSuccessState) {
                      return BlocBuilder<SearchCubit, SearchState>(
                        builder: (context, searchState) {
                          if (searchState is SearchLoadingState) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (searchState is SearchSuccessState) {
                            return _buildEmployeeList(searchState.employeeList);
                          } else if (searchState is SearchErrorState) {
                            return Center(
                                child: Text('Search failed',
                                    style: appFont.f17w500Primary));
                          } else {
                            return _buildEmployeeList(state.employeeList);
                          }
                        },
                      );
                    } else if (state is EmployeeListingErrorState) {
                      return Center(
                        child: Text('Failed to load data',
                            style: appFont.f17w500Primary),
                      );
                    } else {
                      return Center(
                        child: Text('No data available',
                            style: appFont.f17w500Primary),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmployeeList(List<EmployeeModel> employeeList) {
    return ListView.separated(
      itemCount: employeeList.length,
      itemBuilder: (context, index) {
        EmployeeModel employee = employeeList[index];
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
              subtitle:
                  Text('Company: ${employee.company?.name ?? 'No Company'}'),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => appSpaces.spaceForHeight10,
    );
  }
}
