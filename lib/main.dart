import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/core/cubit/employee_cubit/employee_cubit.dart';
import 'package:test_app/core/cubit/search_cubit/search_cubit.dart';
import 'package:test_app/core/models/employee_model.dart';
import 'package:test_app/core/repository/employee_repo.dart';
import 'package:test_app/manager/color_manager.dart';
import 'package:test_app/manager/route_manager.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeModelAdapter());
  Hive.registerAdapter(AddressAdapter());
  Hive.registerAdapter(GeoAdapter());
  Hive.registerAdapter(CompanyAdapter());
  await Hive.openBox<EmployeeModel>('employeeBox');
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => EmployeeRepo(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                EmployeeCubit(employeeRepo: context.read<EmployeeRepo>()),
          ),
          BlocProvider(
            create: (context) =>
                SearchCubit(employeeRepo: context.read<EmployeeRepo>()),
          ),
        ],
        child: GetMaterialApp(
          title: 'Employee App',
          debugShowCheckedModeBanner: true,
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
            appBarTheme: AppBarTheme(color: appColors.brandDark),
            useMaterial3: true,
          ),
          getPages: appRoute(),
          initialRoute: '/',
        ),
      ),
    );
  }
}
