import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/widgets/popup_menu_profile.dart';

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
  bool guideScreen = false;
  bool signInScreen = false;
  bool registerScreen = false;
  bool rulesScreen = false;
  bool pricingScreen = false;
  AppSingleton singleton = AppSingleton();

  checkCurrentPath(title) {
    switch (title) {
      case 'Guide':
        guideScreen = true;
      case 'Sign In':
        signInScreen = true;
      case 'Register':
        registerScreen = true;
      case 'Pricing':
        pricingScreen = true;
      case 'Home':
        homeScreen = true;
      case 'Rules':
        rulesScreen = true;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    checkCurrentPath(widget.title);
    mobile = MediaQuery.of(context).size.width > 700 ? false : true;
    return AppBar(
      automaticallyImplyLeading: mobile ? true : false,
      leading: mobile
          ? Builder(builder: (context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            })
          : null,
      title: mobile
          ? Row(
              children: [
                Image.asset(
                  "assets/images/small_logo.png",
                  width: 65,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          : Row(children: [
              InkWell(
                onTap: () {
                  context.go('/');
                  context.push('/');
                },
                child: Image.asset(
                  'assets/images/small_logo.png',
                  width: 65,
                ), // Reemplaza 'tu_imagen.png' con la ruta de tu imagen.
              ),
              appBarInfoButtons(context)
            ]),
      actions: mobile
          ? null
          : <Widget>[
              Center(
                child: singleton.user != null
                    ? const PopupMenuProfile()
                    : appBarAuthenticationButtons(context),
              )
            ],
      backgroundColor: Colors.deepPurple,
      elevation: 0,
      centerTitle: false,
    );
  }

  Widget appBarTitle(BuildContext context) => const Text(
        "Role MAIster",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );

  Widget appBarInfoButtons(BuildContext context) =>
      Wrap(alignment: WrapAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MaterialButton(
              onPressed: () {
                context.go("/");
                context.push("/");
              },
              child: Column(
                children: [
                  Text(
                    "Home",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: homeScreen ? Colors.white : Colors.grey.shade300,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  homeScreen
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 2),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                        )
                      : const SizedBox()
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {
                context.go("/rules");
                context.push("/rules");
              },
              child: Column(
                children: [
                  Text(
                    "Rules",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: rulesScreen ? Colors.white : Colors.grey.shade300,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  rulesScreen
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 2),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                        )
                      : const SizedBox()
                ],
              ),
            ),
            MaterialButton(
              onPressed: () => context.go('/guide'),
              child: Column(
                children: [
                  Text(
                    "Guide",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: guideScreen ? Colors.white : Colors.grey.shade300,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  guideScreen
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 2),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                        )
                      : const SizedBox()
                ],
              ),
            ),
            MaterialButton(
              onPressed: () => context.go('/pricing'),
              child: Column(
                children: [
                  Text(
                    "Shop",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          pricingScreen ? Colors.white : Colors.grey.shade300,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  pricingScreen
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 2),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ],
        ),
      ]);

  Widget appBarAuthenticationButtons(BuildContext context) => Wrap(
        alignment: WrapAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                onPressed: () => context.go('/sign_in'),
                child: Column(
                  children: [
                    Text(
                      "Sign In",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            signInScreen ? Colors.white : Colors.grey.shade300,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    signInScreen
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 2),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () => context.go('/register'),
                child: Column(
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: registerScreen
                            ? Colors.white
                            : Colors.grey.shade300,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    registerScreen
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 2),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      );

  Widget appBarProfileButtons(BuildContext context) => Wrap(
        alignment: WrapAlignment.end,
        children: [
          MaterialButton(
            onPressed: () => context.go('/profile'),
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.account_circle_outlined,
                    size: 20.0,
                    color: Colors.white,
                  ),
                  color: const Color(0xFF162A49),
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 6,
                ),
                signInScreen
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ],
      );
}
