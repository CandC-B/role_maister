import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/config/firebase_logic.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width > 700 ? false : true;
    return Container(
      alignment: Alignment.center,
      padding: isMobile
          ? const EdgeInsets.symmetric(vertical: 200.0, horizontal: 15)
          : const EdgeInsets.symmetric(vertical: 210.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/dnd.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        width: 450,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.deepPurple, // Border color
            width: 2.0, // Border width
          ),
          color: Colors.white70,
        ),
        child: Padding(
          padding: isMobile
              ? const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0)
              : const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: _formLogin(),
          ),
        ),
      ),
    );
  }

  Widget _formLogin() {
    return Container(
      width: 500,
      height: 300,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Receive an email to reset your password",
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(
            height: 58.5,
          ),
          TextField(
            cursorColor: Colors.deepPurple,
            controller: email,
            decoration: InputDecoration(
              hintText: "Enter email or username",
              fillColor: Colors.blueGrey[50],
              filled: true,
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.shade100,
                    spreadRadius: 10,
                    blurRadius: 20,
                  )
                ]),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              onPressed: () =>
                  firebase.sendPasswordResetEmail(email.text, context),
              child: const SizedBox(
                width: double.infinity,
                height: 50,
                child: Center(child: Text('Reset password')),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginWithButton({required String image, bool isActive = false}) {
    return Container(
      width: 90,
      height: 70,
      decoration: isActive
          ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400,
                    spreadRadius: 2,
                    blurRadius: 15),
              ],
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade400),
            ),
      child: Center(
          child: Image.asset(
        image,
        width: 35,
      )),
    );
  }

  Widget passwordVisionIcon() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isPasswordVisible = !isPasswordVisible;
        });
      },
      child: Icon(
        isPasswordVisible
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
        color: Colors.grey,
      ),
    );
  }

  Widget registerText() {
    return GestureDetector(
        onTap: () {
          context.go("/register");
        },
        child: const Text("Does not have account? Register"));
  }
}
