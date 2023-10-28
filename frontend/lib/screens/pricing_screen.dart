import 'package:flutter/material.dart';
import 'package:role_maister/widgets/appBar/custom_app_bar.dart';

class ShopScreen extends StatelessWidget {
  final List<TokenPackage> tokenPackages = [
    TokenPackage("1 Tokens", 1.0),
    TokenPackage("5 Tokens", 4.0),
    TokenPackage("10 Tokens", 8.0),
    TokenPackage("25 Tokens", 22.0),
    TokenPackage("50 Tokens", 45.0),
  ];

  ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Pricing"),
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
          '\$${tokenPackage.price.toStringAsFixed(2)}',
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        trailing: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.deepPurple)),
          onPressed: () {
            // TODO: Implement payment processing logic here
            // This is where you would integrate a payment gateway.
            // For simplicity, you can show a confirmation dialog here.
            showConfirmationDialog(context);
          },
          child: Text("Buy"),
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
            title: const Text(
              "Confirm Purchase",
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              "Do you want to buy ${tokenPackage.name}?",
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  "Buy",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  // TODO: Implement actual payment processing here
                  // Once payment is successful, you can update the user's token balance.
                  // For this example, you can just close the dialog.
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
      },
    );
  }
}
