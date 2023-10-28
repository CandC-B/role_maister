import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/dnd.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 200.0, vertical: 50.0),
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
                    const Text(
                      'Contact Information',
                      style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Email: candcompany.b@gmail.com',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Phone: +34 123456789',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Address: 25001 Jaume II , Lleida, Spain',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Send Us a Message',
                      style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      cursorColor: Colors.deepPurple,
                      decoration: const InputDecoration(
                        labelText: 'Your Name',
                        labelStyle: TextStyle(color: Colors.black),
                        hintStyle: TextStyle(color: Colors.deepPurple),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .black), // Set the underline color to white
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .deepPurple), // Set the underline color to white when focused
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      cursorColor: Colors.deepPurple,
                      decoration: const InputDecoration(
                        labelText: 'Your Email',
                        labelStyle: TextStyle(color: Colors.black),
                        hintStyle: TextStyle(color: Colors.deepPurple),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .black), // Set the underline color to white
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .deepPurple), // Set the underline color to white when focused
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      cursorColor: Colors.deepPurple,
                      decoration: const InputDecoration(
                        labelText: 'Message',
                        labelStyle: TextStyle(color: Colors.black),
                        hintStyle: TextStyle(color: Colors.deepPurple),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .black), // Set the underline color to white
                        ),
                        focusedBorder: UnderlineInputBorder(
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
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.deepPurple), // Change the background color to blue
                      ),
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            )));
  }
}
