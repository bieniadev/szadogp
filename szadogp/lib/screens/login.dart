import 'package:flutter/material.dart';
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
      //unfocus keyboard
      FocusManager.instance.primaryFocus?.unfocus();

      print('Login: ${emailController.text}');
      print('Password: ${passwordController.text}');

      //update providers status (email, pass)
      ref.read(passInputProvider.notifier).state = passwordController.text;
      ref.read(emailInputProvider.notifier).state = emailController.text;

      // call request
      final userData = ref.watch(loginUserProvider);
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
                  hintText: 'Login',
                ),
                const SizedBox(height: 40),

                // create account click text
                GestureDetector(
                  onTap: () => ref.read(currentScreenProvider.notifier).state =
                      const RegisterScreen(),
                  child: const Text(
                    'Don\'t have account? Sign in',
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
