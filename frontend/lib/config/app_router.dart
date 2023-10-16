import 'package:flutter/material.dart';
import 'package:role_maister/screens/screens.dart';

// TODO Change to GoRouter
class AppRouter {

  static Route onGenerateRoute(RouteSettings settings) {
    print("This is route: ${settings.name}");

    switch (settings.name) {
      case "/":
        return HomeScreen.route();
      case "/rules":
        return RulesScreen.route();
      case "/signin":
        return SignInScreen.route();
      case "/register":
        return RegisterScreen.route();
      default:
      return _errorRoute();
    }
  }

  static Route _errorRoute() {
    
    return MaterialPageRoute(
      settings: const RouteSettings(name: "/error"),
      builder: (_) => Scaffold(appBar: AppBar(title: const Text("Error")),)
      );
  }
}

// class AppRouter {
//   GoRouter
// }