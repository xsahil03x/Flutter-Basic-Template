import 'package:dairy/modules/login/index.dart';
import 'package:dairy/modules/splash/index.dart';
import 'package:dairy/routes/routes.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  /// Add entry for new route here
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.SPLASH:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case Routes.LOGIN:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
