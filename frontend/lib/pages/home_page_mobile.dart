import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomePageMobile extends StatelessWidget {
  const HomePageMobile({super.key});

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
              image: AssetImage('assets/images/dnd_mobile.png'),
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
                'Let an AI be the \n master and enjoy \na role session \nalone or with \nyour friends',
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
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
          left: size.width / 2 - (size.width * 0.25),
          height: size.height * 0.1,
          width: size.width * 0.5,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Colors.deepPurple,
                  textStyle: const TextStyle(
                      fontSize: 36, fontWeight: FontWeight.bold)),
              onPressed: () {
                if (singleton.user != null) {
                  context.push("/mode");
                }else {
                  context.push("/sign_in");
                }
              },
              child: const FittedBox(
                  fit: BoxFit.contain, child: Text("Play Game"))),
        )
      ],
    );
  }
}
