import 'package:get/get.dart';
import 'package:test_app/presentation/screens/details_screen.dart';
import 'package:test_app/presentation/screens/listing_screen.dart';
import 'package:test_app/presentation/screens/splash_screen.dart';

List<GetPage<dynamic>> appRoute() {
  return [
    GetPage(
      name: "/",
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: "/ListingScreen",
      page: () => const ListingScreen(),
    ),
    GetPage(
      name: "/DetailsScreen",
      page: () => DetailsScreen(
        employee: Get.arguments,
      ),
    ),
  ];
}
