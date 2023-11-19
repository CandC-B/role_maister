import 'package:flutter/material.dart';
import 'package:role_maister/widgets/widgets.dart';

class RoleTab extends StatefulWidget {
  RoleTab({super.key, required this.width});

  final double width;

  @override
  _RoleTabState createState() => _RoleTabState();
}

class _RoleTabState extends State<RoleTab> {
  // Create a list to store the presets for each image
  List<bool> presets = [
    false,
    false,
    false
  ]; // Initialize with your default values

  // Function to handle image selection
  void handleImageSelection(int index) {
    // Update the preset value for the selected image
    setState(() {
      for (var i = 0; i < 3; i++) {
        presets[i] = false;
      }
      presets[index] = true;
    });

    // You can also perform other actions based on the selected image
    // For example, navigate to a new route based on the selected image
    switch (index) {
      case 0:
        Navigator.of(context).pushNamed('/game');
        break;
      // Add cases for the other images as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(children: [
      Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            handleImageSelection(
                0); // Call the function with the index of the selected image
          },
          child: ImageColorFilter(
            imagePath: 'assets/images/aliens.jpg',
            routeName: '/game',
            imageText: "ALIENS",
            isAvailable: true,
            height: size.height * 0.9 / 4,
            width: widget.width,
            isLink: false,
            preset: presets[0], // Use the preset value from the list
            isHovering: false,
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            handleImageSelection(
                1); // Call the function with the index of the selected image
          },
          child: ImageColorFilter(
            imagePath: 'assets/images/dungeons_and_dragons.jpg',
            routeName: '/game',
            imageText: "DUNGEONS AND DRAGONS",
            isAvailable: false,
            height: size.height * 0.9 / 4,
            width: widget.width,
            isLink: false,
            preset: presets[1], // Use the preset value from the list
            isHovering: false,
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            handleImageSelection(
                2); // Call the function with the index of the selected image
          },
          child: ImageColorFilter(
            imagePath: 'assets/images/cthulhu.jpg',
            routeName: '/game',
            imageText: "THE CALL OF CTHULHU",
            isAvailable: false,
            height: size.height * 0.9 / 4,
            width: widget.width,
            isLink: false,
            preset: presets[2], // Use the preset value from the list
            isHovering: false,
          ),
        ),
      ),
    ]);
  }
}
