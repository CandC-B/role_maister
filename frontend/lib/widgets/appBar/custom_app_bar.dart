import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String path;

  // const CustomAppBar({super.key});
  const CustomAppBar({super.key, required this.path});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
  
  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool mobile = false;
  bool homeScreen = false;
  bool rulesScreen = false;
  bool signInScreen = false;
  bool registerScreen = false;

  checkCurrentPath(path) {
        switch (path) {
      case '/rules':
        rulesScreen = true;
      case '/sign_in':
        signInScreen = true;
      case '/register':
        registerScreen = true;
      default:
        homeScreen = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkCurrentPath(widget.path);
    mobile = MediaQuery.of(context).size.width > 700 ? false : true;
    return AppBar(
        automaticallyImplyLeading: mobile ? true : false,
        leading: mobile ? Builder(
                  builder: (context) {
                    return IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  }
                ) : null,
        title: mobile ? Image.asset("images/role_maister_logo.png", width: 65,) : 
        Row(
          children: [
            InkWell(
            onTap: () {
              context.go('/');
            },
            child: Image.asset('images/role_maister_logo.png', width: 65,), // Reemplaza 'tu_imagen.png' con la ruta de tu imagen.
          ),
            appBarInfoButtons(context)
          ] 
        ),
        actions: mobile ? null : <Widget> [ Center(
            child: appBarAuthenticationButtons(context),
        )
            
        ],
        backgroundColor: Colors.black87,
        elevation: 0,
        centerTitle: false,
      );
    // return Scaffold(
    //   appBar: AppBar(
    //     automaticallyImplyLeading: mobile ? true : false,
    //     // leading: Navigator.of(context).canPop() ? null : null,
    //     title: mobile ? appBarTitle(context) : 
    //     Row(
    //       children: [
    //         appBarTitle(context),
    //         const SizedBox(width: 100,),
    //         appBarInfoButtons(context)
    //       ] 
    //     ),
    //     actions: mobile ? null : <Widget> [
    //         appBarAuthenticationButtons(context),
    //     ],
    //     backgroundColor: Colors.black87,
    //     elevation: 0,
    //     centerTitle: false,
    //   ),
    //   drawer: mobile ? Drawer(
    //     child: SingleChildScrollView(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //         children: 
    //         [
    //           drawerHeader(context),
    //           drawerItems(context),
    //         ],
    //       ),
    //     ),
    //   ) : null,
    // );
  }

  Widget appBarTitle (BuildContext context) => const Text(
    "Role MAIster", style: TextStyle(
      fontWeight: FontWeight.bold,color:  Colors.deepPurple,),
  );

  Widget appBarInfoButtons (BuildContext context) => Wrap(
    alignment: WrapAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MaterialButton(
            onPressed: () => context.go('/'),
            child: Column(children: [
              Text(
                "Home",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: homeScreen ? Colors.deepPurple : Colors.grey, 
                ),
              ),
              const SizedBox(height: 6,),
              homeScreen ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(30)
                            ),
                ) : const SizedBox()
              ],
            ),
          ),
          MaterialButton(
            onPressed: () => context.go('/rules'),
            child: Column(children: [
              Text(
                "Rules",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: rulesScreen ? Colors.deepPurple : Colors.grey, 
                ),
              ),
              const SizedBox(height: 6,),
              rulesScreen ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(30)
                            ),
                ) : const SizedBox()
              ],
            ),
          ),
        ],
      ),
    ]
  );

  Widget appBarAuthenticationButtons (BuildContext context) => Wrap (
    alignment: WrapAlignment.end,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MaterialButton(
            onPressed: () => context.go('/sign_in'),
            child: Column(children: [
              Text(
                "Sign In",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: signInScreen ? Colors.deepPurple : Colors.grey, 
                ),
              ),
              const SizedBox(height: 6,),
              signInScreen ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(30)
                            ),
                ) : const SizedBox()
              ],
            ),
        ),
        MaterialButton(
            onPressed: () => context.go('/register'),
            child: Column(children: [
              Text(
                "Register",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: registerScreen ? Colors.deepPurple : Colors.grey, 
                ),
              ),
              const SizedBox(height: 6,),
              registerScreen ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(30)
                            ),
                ) : const SizedBox()
              ],
            ),
          ),
        ],
      ),
      const SizedBox(width: 20,),
    ],
  ); 
}



// Widget _menuItem ({required String title, required bool isActive}) {
//   return ElevatedButton(
//       onPressed: () => isActive = true,
//       style: buttonPrimary,
//       child: Column(children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: isActive ? Colors.deepPurple : Colors.grey, 
//           ),
//         ),
//         const SizedBox(height: 6,),
//         isActive ? Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
//           decoration: BoxDecoration(
//             color: Colors.deepPurple,
//             borderRadius: BorderRadius.circular(30)
//           ),
//         ) : const SizedBox()
//       ],
//     ),
//   );
// }

// final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
//   backgroundColor: const Color(0x00000000),
//   elevation: 0,
// );

// Widget _menuItems (BuildContext context) => Wrap(
//   children: [
//      ElevatedButton(
//       onPressed: () {},
//       style: buttonPrimary,
//       child: const Column(children: [
//         Text(
//           "title",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.deepPurple, 
//           ),
//         ),
//         // const SizedBox(height: 6,),
//         // isActive ? Container(
//         //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
//         //   decoration: BoxDecoration(
//         //     color: Colors.deepPurple,
//         //     borderRadius: BorderRadius.circular(30)
//         //   ),
//         // ) : const SizedBox()
//       ],
//     ),
//   ),
//   ],
// );



  


