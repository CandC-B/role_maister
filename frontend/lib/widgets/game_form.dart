import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/models/models.dart';
import 'package:role_maister/widgets/role_tab.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:role_maister/config/config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GameForm extends StatelessWidget {
  GameForm(
      {super.key,
      required this.image_width,
      required this.preset,
      required this.mobile});
  final double image_width;
  final bool preset;
  final bool mobile;
  var _storyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: Colors.black87,
      child: Column(children: [
        Expanded(
            flex: 1,
            child: RoleTab(
              width: image_width,
            )),
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.01, horizontal: size.width * 0.01),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  singleton.pairingMode
                      ? SizedBox()
                      : Text(
                          "${AppLocalizations.of(context)!.number_of_players}1",
                          style: const TextStyle(color: Colors.white),
                        ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  singleton.multiplayer
                      ? SizedBox()
                      : Text(
                          AppLocalizations.of(context)!.brief_description,
                          style: TextStyle(color: Colors.white),
                        ),
                  singleton.multiplayer
                      ? SizedBox()
                      : SizedBox(
                          height: size.height * 0.02,
                        ),
                  singleton.multiplayer
                      ? SizedBox()
                      : Expanded(
                          child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.01,
                              horizontal: size.width * 0.01),
                          decoration: BoxDecoration(
                            color: Colors
                                .black87, // Set the background color to grey
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors
                                  .deepPurple, // Set the border color to purple
                              width: 2.0, // Set the border width
                            ), // Optionally, round the corners
                          ),
                          child: TextFormField(
                            cursorColor: Colors.deepPurple,
                            controller: _storyController,
                            keyboardType: TextInputType.multiline,
                            style: const TextStyle(color: Colors.white),
                            maxLines: null,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!.required;
                              }
                            },
                          ),
                        )),
                ]),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: Column(children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Text(
                "${AppLocalizations.of(context)!.tokens_required}5",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              kIsWeb
                  ? const SizedBox()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: Colors.deepPurple,
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        if (mobile) {
                          singleton.history = _storyController.text;
                          context.go("/select_character");
                        }
                      },
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child:
                              Text(AppLocalizations.of(context)!.start_game))),
            ]),
          ),
        ),
      ]),
    );
  }
}
