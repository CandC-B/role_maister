import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String path;
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
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
      );
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