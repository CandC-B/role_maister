import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

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
  bool pricingScreen= false;
  bool aboutUsScreen = false;
  bool contactUsScreen = false;

  checkCurrentPath(title) {
        switch (title) {
      case 'Rules':
        rulesScreen = true;
      case 'Sign In':
        signInScreen = true;
      case 'Register':
        registerScreen = true;
      case 'Pricing':
        pricingScreen = true;
      case 'About Us':
        aboutUsScreen = true;
      case 'Contact Us':
        contactUsScreen = true;
      default:
        homeScreen = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkCurrentPath(widget.title);
    mobile = MediaQuery.of(context).size.width > 700 ? false : true;
    return AppBar(
        automaticallyImplyLeading: mobile ? true : false,
        leading: mobile ? Builder(
                  builder: (context) {
                    return IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white,),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  }
                ) : null,
        title: mobile ? 
          Row(
            children: [
              Image.asset("images/small_logo.png", width: 65,),
              Align(
                alignment: Alignment.center,
                child: Text(widget.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, ),),
              )
            ]
          ,) :
        Row(
          children: [
            InkWell(
            onTap: () {
              context.go('/');
            },
            child: Image.asset('images/small_logo.png', width: 65,), // Reemplaza 'tu_imagen.png' con la ruta de tu imagen.
          ),
            appBarInfoButtons(context)
          ] 
        ),
        actions: mobile ? null : <Widget> [ Center(
            child: appBarAuthenticationButtons(context),
        )
            
        ],
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        centerTitle: false,
      );
  }

  Widget appBarTitle (BuildContext context) => const Text(
    "Role MAIster", style: TextStyle(
      fontWeight: FontWeight.bold,color:  Colors.white,),
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
                  color: homeScreen ? Colors.white : Colors.grey.shade300, 
                ),
              ),
              const SizedBox(height: 6,),
              homeScreen ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                  color: rulesScreen ? Colors.white : Colors.grey.shade300, 
                ),
              ),
              const SizedBox(height: 6,),
              rulesScreen ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)
                            ),
                ) : const SizedBox()
              ],
            ),
          ),
          MaterialButton(
            onPressed: () => context.go('/pricing'),
            child: Column(children: [
              Text(
                "Pricing",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: pricingScreen ? Colors.white : Colors.grey.shade300, 
                ),
              ),
              const SizedBox(height: 6,),
              pricingScreen ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)
                            ),
                ) : const SizedBox()
              ],
            ),
          ),
          MaterialButton(
            onPressed: () => context.go('/about_us'),
            child: Column(children: [
              Text(
                "About Us",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: aboutUsScreen ? Colors.white : Colors.grey.shade300, 
                ),
              ),
              const SizedBox(height: 6,),
              aboutUsScreen ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)
                            ),
                ) : const SizedBox()
              ],
            ),
          ),
          MaterialButton(
            onPressed: () => context.go('/contact_us'),
            child: Column(children: [
              Text(
                "Contact Us",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: contactUsScreen ? Colors.white : Colors.grey.shade300, 
                ),
              ),
              const SizedBox(height: 6,),
              contactUsScreen ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                  color: signInScreen ? Colors.white : Colors.grey.shade300, 
                ),
              ),
              const SizedBox(height: 6,),
              signInScreen ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                  color: registerScreen ? Colors.white : Colors.grey.shade300, 
                ),
              ),
              const SizedBox(height: 6,),
              registerScreen ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
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