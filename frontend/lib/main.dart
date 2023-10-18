import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/config/app_router.dart';
import 'screens/screens.dart';

void main() {
  runApp(const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // return MaterialApp.router(
    //   title: "Role MAIster",
    //   debugShowCheckedModeBanner: false,
    //   routeInformationParser: ApplicationRouter().router.routeInformationParser,
    //   routerDelegate: ApplicationRouter().router.routerDelegate,
    // );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: ApplicationRouter().router
      // routeInformationParser: AppRouter().router.routeInformationParser,
      // routerDelegate: ApplicationRouter().router.routerDelegate,
    );
  }
}

// final GoRouter _router = GoRouter(
//   routes: <RouteBase>[
//     GoRoute(
//       path: '/',
//       pageBuilder: (BuildContext context, GoRouterState state) {
//             return CustomTransitionPage(
//               key: state.pageKey,
//               child: const HomeScreen(),
//               transitionsBuilder: (context, animation, secondaryAnimation, child) {
//                 return FadeTransition(
//                   opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
//                   child: child
//                   );
//               },
//               );
//           },
//       routes: <RouteBase>[
//         GoRoute(
//           path: 'rules',
//           pageBuilder: (BuildContext context, GoRouterState state) {
//             return CustomTransitionPage(
//               key: state.pageKey,
//               child: const RulesScreen(),
//               transitionsBuilder: (context, animation, secondaryAnimation, child) {
//                 return FadeTransition(
//                   opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
//                   child: child
//                   );
//               },
//             );
//           },
//         ),
//       ],
//     ),
//   ],
// );