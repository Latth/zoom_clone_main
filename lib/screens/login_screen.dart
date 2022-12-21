import 'package:flutter/material.dart';
import 'package:zoom_clone_main/resources/auth_methods.dart';
import 'package:zoom_clone_main/widgets/custom_login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Start or join a meeting",
            style: _loginTitleStyle(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 38),
            child: Image.asset("assets/images/onboarding.jpeg"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: CustomLoginButton(
              text: "Google Sign In",
              function: () async {
                bool res = await _authMethods.signInWithGoogle(context);
                if (res) {
                  // ignore: use_build_context_synchronously
                  // Navigator.pushNamed(context, '/home');
                }
              },
            ),
          )
        ],
      ),
    );
  }

  TextStyle _loginTitleStyle() {
    return const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }
}
