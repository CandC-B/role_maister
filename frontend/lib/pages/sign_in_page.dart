import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/config/app_singleton.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController email = TextEditingController ();
  TextEditingController password = TextEditingController ();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 6),
            child: Container(
              width: 300,
              child: _formLogin(),
            ),
          ),
        ],
      ),
    );
  }


Widget _formLogin() {
  return Column(
    children: [
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
          onPressed: () async {
            try {
              final credential = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: email.text, password: password.text);
              User? user = credential.user;
              // print('User signed in: ${user?.email}');
              AppSingleton singleton = AppSingleton();
              singleton.user = user;
              // ignore: use_build_context_synchronously
              context.go("/");
              // ignore: use_build_context_synchronously
              context.push("/");
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                print('No user found for that email.');
              } else if (e.code == 'wrong-password') {
                print('Wrong password provided for that user.');
              }
            }
          },
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
          _loginWithButton(image: "images/google_logo.png"),
          _loginWithButton(image: "images/github_logo.png", isActive: true),
          _loginWithButton(image: "images/facebook_logo.png"),
        ],
      )
    ],
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
                  color: Colors.grey.shade400, spreadRadius: 2, blurRadius: 15),
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