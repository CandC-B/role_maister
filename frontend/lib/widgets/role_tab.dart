import 'package:flutter/material.dart';
import 'package:role_maister/config/config.dart';
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
    true,
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
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(children: [
      Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            singleton.gameMode.value = "aliens";
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
            singleton.gameMode.value = "dyd";
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
            singleton.gameMode.value = "cthulhu";
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
