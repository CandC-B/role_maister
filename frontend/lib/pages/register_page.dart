import 'package:flutter/material.dart';
import 'package:role_maister/config/firebase_logic.dart';
import 'package:role_maister/config/utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController email = TextEditingController();
  TextEditingController newPassword1 = TextEditingController();
  TextEditingController newPassword2 = TextEditingController();
  bool passwordError = false;
  bool emailError = false;
  bool firebaseAvailable = true;
  bool isPasswordVisible = false;
  void checkRegisterInput() {
    setState(() {
      passwordError = !isPasswordValid(newPassword1.text);
      emailError = !isEmailValid(email.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 7),
            child: Container(
              // TODO poner un recuadro e imagen de fondo
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
        const Text(
          "Register",
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
            counterText: emailError ? "Invalid Email" : null,
            counterStyle: const TextStyle(color: Colors.red),
            fillColor: Colors.blueGrey[50],
            filled: true,
            labelStyle: const TextStyle(fontSize: 12),
            contentPadding: const EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: emailError
                  ? const BorderSide(color: Colors.red)
                  : const BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: emailError
                  ? const BorderSide(color: Colors.red)
                  : const BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        TextField(
          obscureText: !isPasswordVisible,
          controller: newPassword1,
          decoration: InputDecoration(
            hintText: "New password",
            suffixIcon:
                passwordVisionIcon(),
            fillColor: Colors.blueGrey[50],
            filled: true,
            labelStyle: const TextStyle(fontSize: 12),
            contentPadding: const EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: passwordError
                  ? const BorderSide(color: Colors.red)
                  : const BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: passwordError
                  ? const BorderSide(color: Colors.red)
                  : const BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        TextField(
          obscureText: !isPasswordVisible,
          controller: newPassword2,
          decoration: InputDecoration(
            hintText: "New password",
            counterText: passwordError
                ? "At least one letter, one digit and 8 characters"
                : null,
            counterStyle: const TextStyle(color: Colors.red),
            suffixIcon:
                passwordVisionIcon(),
            fillColor: Colors.blueGrey[50],
            filled: true,
            labelStyle: const TextStyle(fontSize: 12),
            contentPadding: const EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: passwordError
                  ? const BorderSide(color: Colors.red)
                  : const BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: passwordError
                  ? const BorderSide(color: Colors.red)
                  : const BorderSide(color: Colors.blueGrey),
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
              if (newPassword1.text == newPassword2.text) {
                checkRegisterInput();
                if (!passwordError && !emailError) {
                  firebase.signUp(email.text, newPassword1.text, context); // TODO Handle if email is already created
                }
              }
            },
            child: const SizedBox(
              width: double.infinity,
              height: 50,
              child: Center(child: Text('Register')),
            ),
          ),
        ),
      ],
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
