import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Container(
          //   width: 360,
          //   child: const Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         'Sign In to Role MAIster',
          //         style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
          //       ),
          //       SizedBox(
          //         height: 30,
          //       ),
          //       Text(
          //         "If you don't have an account",
          //         style: TextStyle(
          //           color: Colors.black54, fontWeight: FontWeight.bold
          //         ),
          //       ),
          //       SizedBox(
          //         height: 10,
          //       ),
          //       Row(
          //         children: [
          //           Text('You can',
          //             style: TextStyle(
          //               color: Colors.black54, fontWeight: FontWeight.bold
          //             ),
          //           ),
          //           SizedBox(width: 15,),
          //           Text('Register here!',
          //             style: TextStyle(
          //               color: Colors.deepPurple, fontWeight: FontWeight.bold
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          // Image.asset("images/role_maister_logo.png", width: 200,),
          // Log in buttons
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 6
            ),
            child: Container(
              width: 300,
              child: _formLogin(),
            ),
            ),
        ],
      ),
    );
  }
}

Widget _formLogin() {
  return Column(children: [
    TextField(
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
    const SizedBox( height: 30,),
    TextField(
      decoration: InputDecoration(
        hintText: "Password",
        counterText: "Forgot password?",
        suffixIcon: const Icon(Icons.visibility_off_outlined, color: Colors.grey),
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
    const SizedBox( height: 40,),
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
        ]
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          )
        ),
        onPressed: () {},
        child: const SizedBox(
          width: double.infinity,
          height: 50,
          child: Center(child: Text('Sign In')),
        ),
      ),
    ),
    const SizedBox( height: 40,),
    Row(
      children: [
        Expanded(
          child: Divider(
            height: 50,
            color: Colors.grey.shade300,
            )
          ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text("Or continue with"),
        ),
        Expanded(
          child: Divider(
            height: 50,
            color: Colors.grey.shade300,
            )
          ),
      ],
    ),
    const SizedBox( height: 40,),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _loginWithButton(image: "images/google_logo.png"),
        _loginWithButton(image: "images/github_logo.png", isActive: true),
        _loginWithButton(image: "images/facebook_logo.png"),
      ],)
  ],
  );
}

Widget _loginWithButton({required String image, bool isActive = false}) {
  return Container(
    width: 90,
    height: 70,
    decoration: isActive ?
    BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade400,
          spreadRadius: 2,
          blurRadius: 15
        ),
      ],
    )
    : BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.grey.shade400),
    ),
    child: Center(
      child: Image.asset(image, width: 35,)
    ),
  );
}