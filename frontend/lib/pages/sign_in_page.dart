import 'package:flutter/material.dart';
import 'package:role_maister/config/firebase_logic.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 110.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/dnd.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
            width: 450,
            height: 600,
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
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
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
      height: 570,
      child: Column(
        children: [
          const Text(
            "Sign In",
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 58.5,
          ),
          TextField(
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
          TextField(
            obscureText: true,
            controller: password,
            decoration: InputDecoration(
              hintText: "Password",
              counterText: "Forgot password?",
              suffixIcon:
                  const Icon(Icons.visibility_off_outlined, color: Colors.grey),
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
            height: 40,
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
                  firebase.signIn(email.text, password.text, context),
              child: const SizedBox(
                width: double.infinity,
                height: 50,
                child: Center(child: Text('Sign In')),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                  child: Divider(
                height: 50,
                color: Colors.grey.shade300,
              )),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text("Or continue with"),
              ),
              Expanded(
                  child: Divider(
                height: 50,
                color: Colors.grey.shade300,
              )),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _loginWithButton(image: "images/google_logo.png", isActive: true),
              _loginWithButton(image: "images/github_logo.png", isActive: true),
              _loginWithButton(
                  image: "images/facebook_logo.png", isActive: true),
            ],
          )
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
}
