import 'package:flutter/material.dart';

import '../features/auth/ui/auth_screen.dart';
import '../features/home/ui/bmi_result_screen.dart';

class Routes {
  static const String initRoute = "/";
  static const String scoreScreen = "/scoreScreen";
  static const String registerScreen = "/register";


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initRoute:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case scoreScreen:
        var data = settings.arguments as double;
        print("################");
        print(data);
        return MaterialPageRoute(builder: (_) => ScoreScreen(bmiScore: data,));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
