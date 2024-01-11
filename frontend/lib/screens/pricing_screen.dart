import 'package:flutter/material.dart';
import 'package:role_maister/config/config.dart';
import 'package:role_maister/widgets/appBar/custom_app_bar.dart';
import 'package:role_maister/widgets/drawer/custom_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShopScreen extends StatelessWidget {
  final List<TokenPackage> tokenPackages = [
    TokenPackage("1 Tokens", 1.0),
    TokenPackage("5 Tokens", 5.0),
    TokenPackage("10 Tokens", 7.0),
    TokenPackage("25 Tokens", 12.0),
    TokenPackage("50 Tokens", 22.0),
  ];

  ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Pricing"),
      drawer: customDrawer(context),
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background4.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.builder(
            itemCount: tokenPackages.length,
            itemBuilder: (context, index) {
              return TokenPackageCard(tokenPackage: tokenPackages[index]);
            },
          )),
    );
  }
}

class TokenPackage {
  final String name;
  final double price;

  TokenPackage(this.name, this.price);
}

class TokenPackageCard extends StatelessWidget {
  final TokenPackage tokenPackage;

  TokenPackageCard({required this.tokenPackage});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.deepPurple, // Change the border color to red
          width: 2.0, // Set the border width as needed
        ),
        borderRadius:
            BorderRadius.circular(12.0), // Adjust the border radius as needed
      ),
      child: ListTile(
        title: Text(
          tokenPackage.name,
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
        subtitle: Text(
          '${tokenPackage.price.toStringAsFixed(2)} \u20AC',
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        trailing: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.deepPurple)),
          onPressed: () {
            // This is where you would integrate a payment gateway.
            // For simplicity, you can show a confirmation dialog here.
            if (singleton.player != null) {
              showConfirmationDialog(context);
            } else {
              showErrorDialog(context);
            }
          },
          child: Text(AppLocalizations.of(context)!.buyButton),
        ),
      ),
    );
  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Text(
            AppLocalizations.of(context)!.confirmButton,
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            // "Do you want to buy ${tokenPackage.name}?",
            "${AppLocalizations.of(context)!.confirmPurchaseText} ${tokenPackage.name}?",
            style: const TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                AppLocalizations.of(context)!.cancel,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                AppLocalizations.of(context)!.buyButton,
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await firebase.changePlayerBalance(context, tokenPackage.price);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Text(
            AppLocalizations.of(context)!.purchase_error_title,
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            // Sign up to buy tokens
            "${AppLocalizations.of(context)!.error_purchasing_tokens}",
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
