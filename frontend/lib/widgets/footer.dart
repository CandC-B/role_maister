import 'package:flutter/material.dart';
import 'package:boxy/flex.dart';

class WebFooter extends StatefulWidget {
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
    // return Container(
    //   color: Colors.black,
    //   child: Row(
    //     children: [
    //       DesktopFooterColumnOne(),
    //       DesktopFooterColumnTwo(),
    //       DesktopFooterColumnThree(),
    //       Flexible(
    //         child: Align(
    //           alignment: Alignment.bottomCenter,
    //           child: FooterCopyright(),
    //         ),
    //       ),
    //     ],
    //   ),
    // );

    // same but if its less than 700px wide, it will be a column
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700) {
          return Container(
            color: Colors.black,
            child: Row(
              children: [
                DesktopFooterColumnOne(),
                DesktopFooterColumnTwo(),
                const SizedBox(width: 50),
                DesktopFooterColumnThree(),
                Flexible(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FooterCopyright(),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            color: Colors.black,
            child: Row(
              children: [
                DesktopFooterColumnOne(),
                Flexible(
                  child: Column(
                    children: [
                      const Divider(color: Colors.black, thickness: 0.5),
                      DesktopFooterColumnTwo(),
                      const Divider(color: Colors.black, thickness: 0.5),
                      DesktopFooterColumnThree(),
                      const Divider(color: Colors.black, thickness: 0.5),
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
          image: AssetImage("images/small_logo.png"),
          width: 200,
        ),

      ),
    ],
  ),
);

class DesktopFooterColumnTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        TextButton(
          onPressed: () => (), // TODO: Add link to about us page
          child: const Text(
            "About Us",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          onPressed: () => (), // TODO: Add link to contact us page
          child: const Text(
            "Contact Us",
            style: TextStyle(
              color: Colors.white,
            ),

          ),
        ),
      ],
    );

  }
}

class DesktopFooterColumnThree extends StatelessWidget {
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