import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class SelectModeMobilePage extends StatefulWidget {
  const SelectModeMobilePage({Key? key});

  @override
  State<SelectModeMobilePage> createState() => _SelectModeMobilePageState();
}

class _SelectModeMobilePageState extends State<SelectModeMobilePage> {
  // Create a list to store the presets for each image
  List<bool> presets = [
    singleton.gameMode.value == "aliens" ? true : false,
    singleton.gameMode.value == "dyd" ? true : false,
    singleton.gameMode.value == "cthulhu" ? true : false
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
    print(presets[index]);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width:
          singleton.multiplayer ? (size.width * 0.8 * 2 / 3) / 3 : size.width,
      height: size.height * 0.9,
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                if (!kIsWeb) {
                  context.go("/select_character");
                } else {
                  singleton.gameMode.value = "aliens";
                  handleImageSelection(0);
                }
              },
              child: ImageColorFilter(
                imagePath: 'assets/images/aliens.jpg',
                routeName: '/form_singleplayer',
                imageText: "ALIENS",
                isAvailable: true,
                height: size.height * 0.9 / 3,
                width: singleton.multiplayer && kIsWeb
                    ? size.width * 0.8 * 2 / 3
                    : size.width,
                isLink: true,
                preset: kIsWeb ? presets[0] : true,
                isHovering: !kIsWeb,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                // context.go("/select_character");
                if (kIsWeb) {
                  singleton.gameMode.value = "dyd";
                  handleImageSelection(1);
                }
              },
              child: ImageColorFilter(
                imagePath: 'assets/images/dungeons_and_dragons.jpg',
                routeName: '/form_singleplayer',
                imageText: "DUNGEONS AND DRAGONS",
                isAvailable: true,
                height: size.height * 0.9 / 3,
                width: singleton.multiplayer && kIsWeb
                    ? size.width * 0.8 * 2 / 3
                    : size.width,
                isLink: false,
                preset: kIsWeb ? presets[1] : true,
                isHovering: !kIsWeb,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                // context.go("/select_character");
                if (kIsWeb) {
                  singleton.gameMode.value = "cthulhu";
                  handleImageSelection(2);
                }
              },
              child: ImageColorFilter(
                imagePath: 'assets/images/cthulhu.jpg',
                routeName: '/form_singleplayer',
                imageText: "THE CALL OF CTHULHU",
                isAvailable: true,
                height: size.height * 0.9 / 3,
                width: singleton.multiplayer && kIsWeb
                    ? size.width * 0.8 * 2 / 3
                    : size.width,
                isLink: false,
                preset: kIsWeb ? presets[2] : true,
                isHovering: !kIsWeb,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
