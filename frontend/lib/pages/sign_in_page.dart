import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/config/firebase_logic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isPasswordVisible = false;
  bool? isInvalidCredentials;
  void checkRegisterInput(bool? isEmailInvalid) {
    setState(() {
      isInvalidCredentials = isEmailInvalid;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width > 700 ? false : true;
    return Container(
      alignment: Alignment.center,
      padding: isMobile
          ? const EdgeInsets.symmetric(vertical: 100.0, horizontal: 15)
          : const EdgeInsets.symmetric(vertical: 150.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/dnd.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        width: 450,
        height: 650,
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
    bool isMobile = MediaQuery.of(context).size.width > 700 ? false : true;
    return Container(
      width: 500,
      height: 570,
      child: Column(
        children: [
           Text(
            AppLocalizations.of(context)!.sign_in,
            style: const TextStyle(
              color: Colors.deepPurple,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          TextField(
            cursorColor: Colors.deepPurple,
            controller: email,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.enter_email,
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
            cursorColor: Colors.deepPurple,
            obscureText: !isPasswordVisible,
            controller: password,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.enter_password,
              suffixIcon: passwordVisionIcon(),
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
            height: 5,
          ),
          Align(
            // TODO SOlve this
            alignment: Alignment.centerRight,
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    isMobile
                        ? context.push("/forgot_password")
                        : context.go("/forgot_password");
                    // context.push("/forgot_password");
                  });
                },
                child:
                    Text(
                    AppLocalizations.of(context)!.forgot_password,
                    textAlign: TextAlign.end)
                  ),
          ),
          const SizedBox(
            height: 20,
          ),
          Visibility(
            visible: isInvalidCredentials ??
                false, // Controla la visibilidad del widget
            child: Text(
              AppLocalizations.of(context)!.invalid_credentials,
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
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
                checkRegisterInput(
                    await firebase.signIn(email.text, password.text, context));
              },
              child:  SizedBox(
                width: double.infinity,
                height: 50,
                child: Center(child: Text(AppLocalizations.of(context)!.sign_in)),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          registerText(),
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
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(AppLocalizations.of(context)!.or_continue_with),
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
              _loginWithButton(
                  image: "assets/images/google_logo.png", isActive: true),
              _loginWithButton(
                  image: "assets/images/github_logo.png", isActive: true),
              _loginWithButton(
                  image: "assets/images/facebook_logo.png", isActive: true),
            ],
          )
        ],
      ),
    );
  }

  Widget _loginWithButton({required String image, bool isActive = false}) {
    bool isMobile = MediaQuery.of(context).size.width > 700 ? false : true;
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
    bool isMobile = MediaQuery.of(context).size.width > 700 ? false : true;
    return GestureDetector(
        onTap: () {
          isMobile ? context.push("/register") : context.go("/register");
        },
        child: Text(AppLocalizations.of(context)!.does_not_have_account));
  }
}
