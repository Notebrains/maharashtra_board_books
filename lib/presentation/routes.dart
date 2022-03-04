import 'package:flutter/material.dart';

import '../common/constants/route_constants.dart';
import 'journeys/home_screen/home.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.dispute: (context) => const Home(),
      };
}
