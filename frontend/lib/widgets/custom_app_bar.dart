import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
  
  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool homeButton = true;
  bool rulesButton = false;
  bool signInButton = false;
  bool registerButton = false;

  void _homeButton() {
    setState(() {
      homeButton = true;
      rulesButton = false;
      signInButton = false;
      registerButton = false;
    });
    Navigator.pushNamed(context, '/');
  }
  void _rulesButton() {
    setState(() {
      homeButton = false;
      rulesButton = true;
      signInButton = false;
      registerButton = false;
    });
    Navigator.pushNamed(context, '/rules');
  }

    void _signInButton() {
    setState(() {
      homeButton = false;
      rulesButton = false;
      signInButton = true;
      registerButton = false;
    });
    Navigator.pushNamed(context, '/signin');
  }
  void _registerButton() {
    setState(() {
      homeButton = false;
      rulesButton = false;
      signInButton = false;
      registerButton = true;
    });
    Navigator.pushNamed(context, '/register');
  }

  bool mobile = false;
  @override
  Widget build(BuildContext context) {
    mobile = MediaQuery.of(context).size.width > 700 ? false : true;
    return Scaffold(
      appBar: AppBar(
        title: mobile ? appBarTitle(context) : 
        Row(
          children: [
            appBarTitle(context),
            const SizedBox(width: 100,),
            appBarInfoButtons(context)
          ] 
        ),
        actions: mobile ? null : <Widget> [
            appBarAuthenticationButtons(context),
        ],
        backgroundColor: Colors.black87,
        elevation: 0,
        centerTitle: false,
      ),
      drawer: mobile ? Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: 
            [
              drawerHeader(context),
              drawerItems(context),
            ],
          ),
        ),
      ) : null,
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
            onPressed: _homeButton,
            child: Column(children: [
              Text(
                "Home",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: homeButton ? Colors.deepPurple : Colors.grey, 
                ),
              ),
              const SizedBox(height: 6,),
              homeButton ? Container(
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
            onPressed: _rulesButton,
            child: Column(children: [
              Text(
                "Rules",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: rulesButton ? Colors.deepPurple : Colors.grey, 
                ),
              ),
              const SizedBox(height: 6,),
              rulesButton ? Container(
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
            onPressed: _signInButton,
            child: Column(children: [
              Text(
                "Sign In",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: signInButton ? Colors.deepPurple : Colors.grey, 
                ),
              ),
              const SizedBox(height: 6,),
              signInButton ? Container(
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
            onPressed: _registerButton,
            child: Column(children: [
              Text(
                "Register",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: registerButton ? Colors.deepPurple : Colors.grey, 
                ),
              ),
              const SizedBox(height: 6,),
              registerButton ? Container(
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


Widget drawerHeader (BuildContext context) => Material(
  color: Colors.deepPurple,
  child: InkWell(
    onTap: () {},
    child: Container(
      padding: EdgeInsets.only(
        top: 24 + MediaQuery.of(context).padding.top,
        bottom: 24,
      ),
      child: const Column(
        children: [
          CircleAvatar(
            radius: 52,
            backgroundImage: AssetImage("images/role_maister_logo.png"),
          ),
          SizedBox(height: 12,),
          Text("Username", style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white, 
            ),
          ),
          SizedBox(height: 12,),
          Text("User Email", style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white, 
            ),
          ),
        ],
      ),
    )
    )
  );
  
Widget drawerItems (BuildContext context) => Wrap(
  children: [
    ListTile(
      leading: const Icon(Icons.home_outlined, color: Colors.deepPurple,),
      title: const Text("Home", style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple, 
          ),),
      onTap: () {} /*=> 
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage())*/,
    ),
    ListTile(
      leading: const Icon(Icons.rule_outlined, color: Colors.deepPurple,),
      title: const Text("Rules", style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple, 
          ),),
      onTap: () {}/*=> 
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RulesPage())*/,
    ),
    const Divider(color: Colors.black54,),
    ListTile(
      leading: const Icon(Icons.info_outline, color: Colors.deepPurple,),
      title: const Text("About Us", style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple, 
          ),),
      onTap: () {}/*=> 
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RulesPage())*/,
    ),
    ListTile(
      leading: const Icon(Icons.help_outline, color: Colors.deepPurple,),
      title: const Text("Help", style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple, 
          ),),
      onTap: () {}/*=> 
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RulesPage())*/,
    ),
  ],
);