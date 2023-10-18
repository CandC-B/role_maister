import 'package:flutter/material.dart';
import 'package:role_maister/pages/pages.dart';
import 'package:role_maister/widgets/widgets.dart';

class PricingScreen extends StatelessWidget {
  const PricingScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Pricing"),
      drawer: customDrawer(context),
      body: const PricingPage()
    );
  }
}