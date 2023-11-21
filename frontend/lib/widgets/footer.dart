import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WebFooter extends StatefulWidget {
  const WebFooter({super.key});

  @override
  State<WebFooter> createState() => _WebFooterState();
}

class _WebFooterState extends State<WebFooter> {
  @override
  Widget build(BuildContext context) {
    return const BoxyDesktopFooter();
  }
}

class BoxyDesktopFooter extends StatelessWidget {
  const BoxyDesktopFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700) {
          return Container(
            color: Colors.deepPurple,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: const DesktopFooterColumnOne(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: const DesktopFooterColumnTwo(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: const DesktopFooterColumnThree(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: const FooterCopyright(),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            color: Colors.deepPurple,
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DesktopFooterColumnOne(),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Divider(color: Colors.deepPurple, thickness: 0.5),
                      DesktopFooterColumnTwo(), // TODO make that this part centers like the other two (Check web in mobile window size)
                      Divider(color: Colors.deepPurple, thickness: 0.5),
                      DesktopFooterColumnThree(),
                      Divider(color: Colors.deepPurple, thickness: 0.5),
                      FooterCopyright(),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class DesktopFooterColumnOne extends StatelessWidget {
  const DesktopFooterColumnOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        appLogoMark,
      ],
    );
  }
}

final RichText appLogoMark = RichText(
  text: const TextSpan(
    children: [
      WidgetSpan(
        child: Image(
          image: AssetImage("assets/images/small_logo.png"),
          width: 200,
        ),
      ),
    ],
  ),
);

class DesktopFooterColumnTwo extends StatelessWidget {
  const DesktopFooterColumnTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AboutUsIconAndText(),
        ContactUsIconAndText(),
        TermsIconAndText(),
      ],
    );
  }
}

class DesktopFooterColumnThree extends StatelessWidget {
  const DesktopFooterColumnThree({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          "C&C - B",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Text(
          "C/ de Jaume II, 69",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Text(
          "25001",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Text(
          "Lleida",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class FooterCopyright extends StatelessWidget {
  const FooterCopyright({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "©2023 C&C - B",
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }
}

class AboutUsIconAndText extends StatelessWidget {
  const AboutUsIconAndText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.info_outline,
            size: 20.0,
            color: Colors.white,
          ),
          color: const Color(0xFF162A49),
          onPressed: () {},
        ),
        TextButton(
          onPressed: () => context.go('/about_us'),
          child: Text(
            AppLocalizations.of(context)!.about_us,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class ContactUsIconAndText extends StatelessWidget {
  const ContactUsIconAndText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.mail_outline,
            size: 20.0,
            color: Colors.white,
          ),
          color: const Color(0xFF162A49),
          onPressed: () => context.go('/contact_us'),
        ),
        TextButton(
          onPressed: () => context.go('/contact_us'),
          child: Text(
            AppLocalizations.of(context)!.contact_us,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class TermsIconAndText extends StatelessWidget {
  const TermsIconAndText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.history_edu_outlined,
            size: 20.0,
            color: Colors.white,
          ),
          color: const Color(0xFF162A49),
          onPressed: () => context.go('/terms_conditions'),
        ),
        TextButton(
          onPressed: () => context.go('/terms_conditions'),
          child: Text(
            AppLocalizations.of(context)!.terms_and_conditions,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:footer/footer.dart';

// class WebFooter extends StatelessWidget {
//   const WebFooter({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Footer(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children:<Widget>[
//                   Center(
//                     child:Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         Container(
//                           height: 45.0,
//                           width: 45.0,
//                           margin: const EdgeInsets.only(right: 0),
//                           child: Center(
//                             child:Card(
//                               elevation: 5.0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(25.0), // half of height and width of Image
//                               ),
//                               child: IconButton(
//                                 icon: const Icon(Icons.info_outline,size: 20.0,),
//                                 color: const Color(0xFF162A49),
//                                 onPressed: () {},
//                               ),
//                             ),
//                           )
//                         ),
//                         Container(
//                           height: 45.0,
//                           width: 45.0,
//                           margin: const EdgeInsets.only(right: 0),
//                           child: Center(
//                             child:Card(
//                               elevation: 5.0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(25.0), // half of height and width of Image
//                               ),
//                               child: IconButton(
//                                 icon: const Icon(Icons.mail_outline,size: 20.0,),
//                                 color: const Color(0xFF162A49),
//                                 onPressed: () {},
//                               ),
//                             ),
//                           )
//                         ),
//                         Container(
//                           height: 45.0,
//                           width: 45.0,
//                           margin: const EdgeInsets.only(right: 0),
//                           child: Center(
//                             child:Card(
//                               elevation: 5.0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(25.0), // half of height and width of Image
//                               ),
//                               child: IconButton(
//                                 icon: const Icon(Icons.call,size: 20.0,),
//                                 color: const Color(0xFF162A49),
//                                 onPressed: () {},
//                               ),
//                             ),
//                           )
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Text('Copyright ©2020, All Rights Reserved.',style: TextStyle(fontWeight:FontWeight.w300, fontSize: 12.0, color: Color(0xFF162A49)),),
//                   const Text('Powered by Nexsport',style: TextStyle(fontWeight:FontWeight.w300, fontSize: 12.0,color: Color(0xFF162A49)),),
//                 ]
//               ),
//           );
//   }
// }