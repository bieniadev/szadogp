import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/components/input_textfield.dart';
import 'package:szadogp/components/submit_button.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/screens/home.dart';
import 'package:szadogp/screens/login.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    //sign in user method
    signUserIn(WidgetRef ref) {
      print('Login: ${usernameController.text}');
      print('Password: ${passwordController.text}');

      //set current screen to home;
      //   ref.read(currentScreenProvider.notifier).state = const HomeScreen();
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //jakiś img/ikona ?
                const SizedBox(height: 120),
                const Text('Elo mordziaty, register swoj daj', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 40),

                //login input
                InputTextfield(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                const SizedBox(height: 15),

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
                      onTap: () => ref.read(currentScreenProvider.notifier).state = const LoginScreen(),
                      child: const Text('Koxówa mordo dawaj login'),
                    ),
                  ]),
                ),
                const SizedBox(height: 30),

                //sign in button
                SubmitButton(
                  onTap: () => signUserIn(ref),
                  hintText: 'Zarejestruj się',
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
