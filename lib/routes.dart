

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:pet_adopt_app/pages/details_screen.dart';
import 'package:pet_adopt_app/pages/history_screen.dart';
import 'package:pet_adopt_app/pages/home_screen.dart';



class Routes {
  static const String homeScreen = '/homeScreen';
static const String detailsScreen = '/detailsScreen';
static const String historyScreen='/historyScreen';
}

class AppRouter {
  static List<GetPage> routes = [
    GetPage(
        name: Routes.homeScreen,
        page: () => const HomeScreen()),

    GetPage(
        name: Routes.detailsScreen,
        page: () => const DetailsScreen(
        
            )),
            GetPage(
        name: Routes.historyScreen,
        page: () => const HistoryScreen(
        
            )),
  ];
}
