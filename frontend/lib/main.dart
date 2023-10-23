import 'package:flutter/material.dart';
import 'package:role_maister/config/app_router.dart';

void main() {
  runApp(const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: ApplicationRouter().router
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:footer/footer.dart';
// import 'package:footer/footer_view.dart';
// import 'package:role_maister/pages/pages.dart';
// import 'package:role_maister/screens/screens.dart';
// import 'package:role_maister/widgets/widgets.dart';
// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   static Map<int, Color> color = {
//     50:Color.fromRGBO(4, 131, 184, .1),
//     100:Color.fromRGBO(4, 131, 184, .2),
//     200:Color.fromRGBO(4, 131, 184, .3),
//     300:Color.fromRGBO(4, 131, 184, .4),
//     400:Color.fromRGBO(4, 131, 184, .5),
//     500:Color.fromRGBO(4, 131, 184, .6),
//     600:Color.fromRGBO(4, 131, 184, .7),
//     700:Color.fromRGBO(4, 131, 184, .8),
//     800:Color.fromRGBO(4, 131, 184, .9),
//     900:Color.fromRGBO(4, 131, 184, 1),
//   };
//   //MaterialColor myColor = MaterialColor(0xFF162A49, color);
  
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Footer',
//       theme: ThemeData(
//         primarySwatch: MaterialColor(0xFF162A49, color),
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: FooterPage(),
//     );
//   }
// }

// class FooterPage extends StatefulWidget {
//   @override
//   FooterPageState createState() {
//     return FooterPageState();
//   }
// }

// class FooterPageState extends State<FooterPage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const  Text('Flutter Footer View',style: TextStyle(fontWeight:FontWeight.w200),)
//       ),
//       drawer: const Drawer(),
//       body: ListView(
//         children: const [
//           FantasyHome(),
//           WebFooter2()
//         ],
//       ),
//     );
//   }
// }

