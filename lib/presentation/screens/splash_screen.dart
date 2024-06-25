import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:test_app/core/repository/employee_repo.dart';
import 'package:test_app/manager/color_manager.dart';
import 'package:test_app/manager/font_manager.dart';
import 'package:test_app/manager/space_manger.dart';
import 'package:test_app/utils/geolocate.dart';
import 'package:test_app/utils/get_dimension.dart';
import 'package:test_app/widgets/custom_snackBar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final EmployeeRepo repo = EmployeeRepo();
  final connectivityResult = Connectivity().checkConnectivity();
  Position? myPosition;

  @override
  void initState() {
    repo.getAllEmployees();
    if (connectivityResult == ConnectivityResult.none) {
      customSnackBar(
          title: 'Bad Connection', message: 'Internet Connection Failed');
    }
    locationPermission();
    super.initState();
  }

  locationPermission() async {
    myPosition = await determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    splashFunction();
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: screenHeight(context) * 0.14,
          width: screenHeight(context) * 0.14,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: appColors.brandDark, width: 5),
              image: const DecorationImage(
                  image: NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
                  fit: BoxFit.cover)),
        ),
        appSpaces.spaceForHeight15,
        Text(
          'Employee App',
          style: appFont.f17w500Primary,
          maxLines: 2,
          textAlign: TextAlign.center,
        )
      ],
    )));
  }

  splashFunction() async {
    Future.delayed(const Duration(seconds: 5)).then((value) {
      Get.offAllNamed("/ListingScreen");
    });
  }
}
