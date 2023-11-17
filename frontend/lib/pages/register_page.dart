import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/config/firebase_logic.dart';
import 'package:role_maister/config/utils.dart';
import 'package:role_maister/models/player.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController newPassword1 = TextEditingController();
  TextEditingController newPassword2 = TextEditingController();
  bool passwordError = false;
  bool usernameError = false;
  bool emailError = false;
  bool firebaseAvailable = true;
  bool isPasswordVisible = false;
  bool isRulesCheckBoxChecked = false;
  void checkRegisterInput(bool isUsernameError) {
    setState(() {
      passwordError = !isPasswordValid(newPassword1.text);
      emailError = !isEmailValid(email.text);
      usernameError = isUsernameError;
    });
  }

  void emailAlreadyExist() {
    setState(() {
      emailError = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width > 700 ? false : true;
    return Container(
      alignment: Alignment.center,
      padding: isMobile
          ? const EdgeInsets.symmetric(vertical: 100.0, horizontal: 15)
          : const EdgeInsets.symmetric(vertical: 170.0),
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
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 40.0),
          child: Container(
            child: _formRegister(),
          ),
        ),
      ),
    );
  }

  Widget _formRegister() {
    return Container(
        width: 500,
        height: 500,
        child: Column(children: [
          const Text(
            "Register",
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          TextField(
            cursorColor: Colors.deepPurple,
            controller: username,
            decoration: InputDecoration(
              hintText: "Enter username",
              counterText: usernameError ? "This username already exist" : null,
              counterStyle: const TextStyle(color: Colors.red),
              fillColor: Colors.blueGrey[50],
              filled: true,
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: usernameError
                    ? const BorderSide(color: Colors.red)
                    : const BorderSide(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: usernameError
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
            cursorColor: Colors.deepPurple,
            controller: email,
            decoration: InputDecoration(
              hintText: "Enter email",
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
            cursorColor: Colors.deepPurple,
            obscureText: !isPasswordVisible,
            controller: newPassword1,
            decoration: InputDecoration(
              hintText: "New password",
              suffixIcon: passwordVisionIcon(),
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
            cursorColor: Colors.deepPurple,
            obscureText: !isPasswordVisible,
            controller: newPassword2,
            decoration: InputDecoration(
              hintText: "New password",
              counterText: passwordError
                  ? "At least one letter, one digit and 8 characters"
                  : null,
              counterStyle: const TextStyle(color: Colors.red),
              suffixIcon: passwordVisionIcon(),
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
            height: 20,
          ),
          Row(
            children: [
              Checkbox(
                  value: isRulesCheckBoxChecked,
                  activeColor: Colors.deepPurple,
                  onChanged: (bool? value) {
                    setState(() {
                      isRulesCheckBoxChecked = value!;
                    });
                  }),
              RichText(
                text: TextSpan(
                  text: 'I accept the ',
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'game rules',
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Aquí puedes manejar la acción cuando se hace clic en "game rules"
                          context.go("/rules");
                        },
                    ),
                    const TextSpan(
                      text: ' *',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
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
                // TODO remove comments in production
                if (newPassword1.text == newPassword2.text) {
                  bool usernameError = await isUsernameValid(username.text);
                  checkRegisterInput(usernameError);
                  if (!passwordError &&
                      !emailError &&
                      !usernameError &&
                      isRulesCheckBoxChecked) {
                    User? user = await firebase.signUp(
                        email.text, newPassword1.text, context);
                      print("user");

                    if (user != null) {
                      print("user not null");
                      Player player = Player(uid: user.uid, username: username.text ,email: user.email, tokens: 5 ,aliensCharacters: [], dydCharacters: [], cthulhuCharacters: [],gamesPlayed: 0, experience: 1);
                      // singleton.user = user;
                      singleton.player = player;
                      firebase.saveUser(player);
                    } else {
                      print("user null");
                      emailAlreadyExist();
                    }
                  }
                }
              },
              child: const SizedBox(
                width: double.infinity,
                height: 50,
                child: Center(child: Text('Register')),
              ),
            ),
          )
        ]));
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
