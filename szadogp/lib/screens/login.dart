import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/components/input_textfield.dart';
import 'package:szadogp/components/submit_button.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/providers/login_user.dart';
import 'package:szadogp/screens/home.dart';
import 'package:szadogp/screens/register.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // controlers for texfield inputs
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    //sign in user method
    signUserIn(WidgetRef ref) {
      print('Login: ${emailController.text}');
      print('Password: ${passwordController.text}');

      //kod ktory wysyła do api moj login i haslo (zadanie)
      ref.read(passInputProvider.notifier).state = passwordController.text;
      ref.read(emailInputProvider.notifier).state = emailController.text;

      //set current screen to home;
      ref.read(currentScreenProvider.notifier).state = const HomeScreen();
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Image.asset('assets/images/logo.png'),
                const SizedBox(height: 40),
                const Text('Elo mordziaty, sprawdzaj swoje staty!', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 40),

                //login input
                InputTextfield(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 15),

                //password input
                InputTextfield(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 20),

                // create account text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    GestureDetector(
                      onTap: () => ref.read(currentScreenProvider.notifier).state = const RegisterScreen(),
                      child: const Text('Jakiś register zółtodziobie?'),
                    ),
                  ]),
                ),
                const SizedBox(height: 30),

                //sign in button
                SubmitButton(
                  onTap: () => signUserIn(ref),
                  hintText: 'Zaloguj się',
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
