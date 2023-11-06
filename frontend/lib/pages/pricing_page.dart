// class ShopScreen extends StatelessWidget {
//   final List<TokenPackage> tokenPackages = [
//     TokenPackage("100 Tokens", 10.0),
//     TokenPackage("500 Tokens", 40.0),
//     TokenPackage("1000 Tokens", 75.0),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Token Shop'),
//       ),
//       body: ListView.builder(
//         itemCount: tokenPackages.length,
//         itemBuilder: (context, index) {
//           return TokenPackageCard(tokenPackage: tokenPackages[index]);
//         },
//       ),
//     );
//   }
// }

// class TokenPackage {
//   final String name;
//   final double price;

//   TokenPackage(this.name, this.price);
// }

// class TokenPackageCard extends StatelessWidget {
//   final TokenPackage tokenPackage;

//   TokenPackageCard({required this.tokenPackage});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         title: Text(tokenPackage.name),
//         subtitle: Text('\$${tokenPackage.price.toStringAsFixed(2)}'),
//         trailing: ElevatedButton(
//           onPressed: () {
//             // TODO: Implement payment processing logic here
//             // This is where you would integrate a payment gateway.
//             // For simplicity, you can show a confirmation dialog here.
//             showConfirmationDialog(context);
//           },
//           child: Text("Buy"),
//         ),
//       ),
//     );
//   }

//   void showConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Confirm Purchase"),
//           content: Text("Do you want to buy ${tokenPackage.name}?"),
//           actions: <Widget>[
//             TextButton(
//               child: Text("Cancel"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text("Buy"),
//               onPressed: () {
//                 // TODO: Implement actual payment processing here
//                 // Once payment is successful, you can update the user's token balance.
//                 // For this example, you can just close the dialog.
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }