import 'package:flutter/material.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:role_maister/config/config.dart';

class SelectCharacterPageMobile extends StatelessWidget {
  const SelectCharacterPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.red,
    );
  }
}
