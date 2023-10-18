import 'package:flutter/material.dart';
import 'package:role_maister/pages/pages.dart';
import 'package:role_maister/widgets/widgets.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});
  // @override
  // Widget build(BuildContext context) {
  //   return const Scaffold(
  //     appBar: CustomAppBar(),
  //     body: RulesPage(),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(path: "/rules"),
      drawer: customDrawer(context),
      body: const RulesPage()
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class RulesScreen extends StatelessWidget {
//   /// Constructs a [DetailsScreen]
//   const RulesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Rules Screen')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => context.go('/'),
//           child: const Text('Go back to the Home screen'),
//         ),
//       ),
//     );
//   }
// }