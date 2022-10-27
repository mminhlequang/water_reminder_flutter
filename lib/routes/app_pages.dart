
import 'package:get/get.dart';

import '../tracking-drinkwater/bindings/tracking_drinkwater_binding.dart';
import '../tracking-drinkwater/views/water_reminder/water_reminder_view.dart';



part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.TRACKING_DRINKWATER;

  static final routes = [
    GetPage(
      name: _Paths.TRACKING_DRINKWATER,
      page: () =>  TrackingDrinkwaterView(),
      binding: TrackingDrinkwaterBinding(),
    ),
  ];
}
