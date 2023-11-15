import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width < 700;

    return Container(
      width: size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background2.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: isMobile
            ? const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0)
            : const EdgeInsets.symmetric(horizontal: 100.0, vertical: 50.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.deepPurple, // Border color
              width: 2.0, // Border width
            ),
            color: Colors.white70,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(children: <Widget>[
              Text(
                AppLocalizations.of(context)!.rules,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                AppLocalizations.of(context)!.rules_text1,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.rules_text2,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              const SizedBox(height: 10),
              Text(
                '${AppLocalizations.of(context)!.rules_text3}'
                '${AppLocalizations.of(context)!.rules_text4}'
                '${AppLocalizations.of(context)!.rules_text5}'
                '${AppLocalizations.of(context)!.rules_text6}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Rules',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              const SizedBox(height: 10),
              Text(
                '${AppLocalizations.of(context)!.rules_text7}'
                '${AppLocalizations.of(context)!.rules_text8}'
                '${AppLocalizations.of(context)!.rules_text9}'
                '${AppLocalizations.of(context)!.rules_text10}'
                '${AppLocalizations.of(context)!.rules_text11}'
                '${AppLocalizations.of(context)!.rules_text12}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
