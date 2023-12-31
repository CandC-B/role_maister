import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/dnd.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: size.height / 2,
          width: size.width,
          alignment: const Alignment(0.0, -0.1),
          child: FittedBox(
            fit: BoxFit.contain,
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 80.0,
                fontWeight: FontWeight.w900,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
              child: GradientText(
                AppLocalizations.of(context)!.homePageText,
                overflow: TextOverflow.ellipsis,
                colors: const [
                  Color.fromARGB(255, 226, 220, 161),
                  Color.fromARGB(255, 152, 133, 223),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: size.height / 2 + 50,
          left: size.width / 2 - (size.width * 0.1),
          height: size.height * 0.1,
          width: size.width * 0.2,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Colors.deepPurple,
                  textStyle: const TextStyle(
                      fontSize: 36, fontWeight: FontWeight.bold)),
              onPressed: () {
                if (singleton.user != null) {
                  context.go("/mode");
                } else {
                  context.go("/sign_in");
                }
              },
              child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(AppLocalizations.of(context)!.playGame))),
        ),
      ],
    );
  }
}