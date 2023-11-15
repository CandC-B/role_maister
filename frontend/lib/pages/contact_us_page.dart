import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

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
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.contact_info,
                      style: const TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      '${AppLocalizations.of(context)!.email}: candcompany.b@gmail.com',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${AppLocalizations.of(context)!.phone}: +34 123456789',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${AppLocalizations.of(context)!.address}: 25001 Jaume II , Lleida, Spain',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      AppLocalizations.of(context)!.send_a_message,
                      style: const TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      cursorColor: Colors.deepPurple,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.your_name,
                        labelStyle: const TextStyle(color: Colors.black),
                        hintStyle: const TextStyle(color: Colors.deepPurple),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .black), // Set the underline color to white
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .deepPurple), // Set the underline color to white when focused
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      cursorColor: Colors.deepPurple,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.your_email,
                        labelStyle: const TextStyle(color: Colors.black),
                        hintStyle: const TextStyle(color: Colors.deepPurple),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .black), // Set the underline color to white
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .deepPurple), // Set the underline color to white when focused
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      cursorColor: Colors.deepPurple,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.message,
                        labelStyle: const TextStyle(color: Colors.black),
                        hintStyle: const TextStyle(color: Colors.deepPurple),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .black), // Set the underline color to white
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .deepPurple), // Set the underline color to white when focused
                        ),
                      ),
                      maxLines: 5,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Handle form submission or send email functionality
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors
                            .deepPurple), // Change the background color to blue
                      ),
                      child: Text(AppLocalizations.of(context)!.submit),
                    ),
                  ],
                ),
              ),
            )));
  }
}
