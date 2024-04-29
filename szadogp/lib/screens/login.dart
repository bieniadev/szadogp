import 'package:flutter/material.dart';
import 'package:szadogp/components/input_textfield.dart';
import 'package:szadogp/components/submit_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  // controlers for texfield inputs
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //sign in user method
  void signUserIn() {
    print('Login: ${usernameController.text}');
    print('Password: ${passwordController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //jakiś img/ikona ?
                const SizedBox(height: 120),
                const Text('Elo mordziaty, sprawdzaj swoje staty!', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 40),

                //login input
                InputTextfield(
                  controller: usernameController,
                  hintText: 'Login',
                  obscureText: false,
                ),
                const SizedBox(height: 15),

                //password input
                InputTextfield(
                  controller: passwordController,
                  hintText: 'Hasło',
                  obscureText: true,
                ),
                const SizedBox(height: 20),

                // create account text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.end, children: const [
                    Text('Jakiś register zółtodziobie?'),
                  ]),
                ),
                const SizedBox(height: 30),

                //sign in button
                SubmitButton(onTap: signUserIn),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
