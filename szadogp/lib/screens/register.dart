import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/components/input_textfield.dart';
import 'package:szadogp/components/submit_button.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/providers/register_user.dart';
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
      print('Email: ${emailController.text}');

      //update providers status (email, pass, username)
      ref.read(passInputProvider.notifier).state = passwordController.text;
      ref.read(emailInputProvider.notifier).state = emailController.text;
      ref.read(usernameInputProvider.notifier).state = usernameController.text;

      // call request
      final userData = ref.watch(registerUserProvider);
      // userData.whenData((value) => print(value));
      userData.when(data: (userResponse) {
        String userToken = userResponse;
        print(
            'Twoj token: $userToken'); //zapisz do zmienej lokalnej userToken ok?
        print(ref.read(currentScreenProvider.notifier).state);
        //set current screen to home;
        ref.read(currentScreenProvider.notifier).state = const HomeScreen();
        print(ref.read(currentScreenProvider.notifier).state);
      }, error: (err, s) {
        print('$err');
      }, loading: () {
        print('laduje');
      });
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                const SizedBox(height: 150),
                Image.asset('assets/images/logo.png'),
                const SizedBox(height: 150),

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

                //sign in button
                SubmitButton(
                  onTap: () => signUserIn(ref),
                  hintText: 'Create account',
                ),
                const SizedBox(height: 40),

                // create account click text
                GestureDetector(
                  onTap: () => ref.read(currentScreenProvider.notifier).state =
                      const LoginScreen(),
                  child: const Text(
                    'Have account? Log in',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
