import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/pages/pages.dart';
import 'package:role_maister/screens/screens.dart';

// TODO Change to GoRouter
// class AppRouter {

//   static Route onGenerateRoute(RouteSettings settings) {
//     print("This is route: ${settings.name}");

//     switch (settings.name) {
//       case "/":
//         return HomeScreen.route();
//       case "/rules":
//         return RulesScreen.route();
//       case "/signin":
//         return SignInScreen.route();
//       case "/register":
//         return RegisterScreen.route();
//       default:
//       return _errorRoute();
//     }
//   }

//   static Route _errorRoute() {
    
//     return MaterialPageRoute(
//       settings: const RouteSettings(name: "/error"),
//       builder: (_) => Scaffold(appBar: AppBar(title: const Text("Error")),)
//       );
//   }
// }

class ApplicationRouter {
  GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: HomeScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                  child: child
                  );
              },
              );
          },
      routes: <RouteBase>[
        GoRoute(
          path: 'rules',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: RulesScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                  child: child
                  );
              },
            );
          },
        ),
        GoRoute(
          path: 'sign_in',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: SignInScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                  child: child
                  );
              },
            );
          },
        ),
        GoRoute(
          path: 'register',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: RegisterScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                  child: child
                  );
                },
              );
            },
          ),
        ],
      ),
    ],
  );
}

