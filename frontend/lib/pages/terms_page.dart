import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width < 700;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/dnd.png'),
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
                AppLocalizations.of(context)!.terms_and_conditions,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                AppLocalizations.of(context)!.termsAndConditions_text1,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.termsAndConditions_text2,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              const SizedBox(height: 10),
              Text(
                '${AppLocalizations.of(context)!.termsAndConditions_text3}'
                '${AppLocalizations.of(context)!.termsAndConditions_text4}'
                '${AppLocalizations.of(context)!.termsAndConditions_text5}'
                '${AppLocalizations.of(context)!.termsAndConditions_text6}'
                '${AppLocalizations.of(context)!.termsAndConditions_text7}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
            ]),
          ),
        ),
      ),
    );
  }
}
