import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:szadogp/components/input_textfield.dart';
import 'package:szadogp/components/submit_button.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/providers/is_loading.dart';
import 'package:szadogp/providers/user_data.dart';
import 'package:szadogp/providers/user_token.dart';
import 'package:szadogp/screens/home.dart';
import 'package:szadogp/screens/register.dart';
import 'package:szadogp/services/services.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dbRef = Hive.box('user-token');
    String dbToken = dbRef.get(1) ?? '';

    // controlers for texfield inputs
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    bool isLoading = false;

    //sign in user method
    signUserIn(WidgetRef ref) async {
      //read inputs from controlers
      final password = passwordController.text;
      final email = emailController.text;

      try {
        //call request
        final String response = await ApiServices().loginCredentials(email, password);
        // if db token is empty > set to localdb AND provider token from response
        if (dbToken == '') {
          ref.read(userTokenProvider.notifier).state = response;
          dbRef.put(1, response);
        }
        ref.invalidate(userDataProvider);
        final Map<String, dynamic> userInfoResponse = await ApiServices().getUserInfo();
        ref.read(userInfoProvider.notifier).state = userInfoResponse;

        //unfocus keyboard
        FocusManager.instance.primaryFocus?.unfocus();

        //set current screen to home;
        ref.read(currentScreenProvider.notifier).state = const HomeScreen();
        ref.read(isLoadingProvider.notifier).state = false;
      } catch (err) {
        ref.read(isLoadingProvider.notifier).state = false;
        // ignore: use_build_context_synchronously
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 5),
          content: Text('$err'),
          backgroundColor: Colors.red,
        ));
      }
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
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 15),

                //password input
                InputTextfield(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 20),

                //sign in button
                SubmitButton(
                    onTap: () {
                      signUserIn(ref);
                    },
                    hintWidget: !isLoading
                        ? const Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2),
                          )
                        // ignore: dead_code
                        : const CircularProgressIndicator(color: Colors.white)),
                const SizedBox(height: 40),

                // create account click text
                GestureDetector(
                  onTap: () => ref.read(currentScreenProvider.notifier).state = const RegisterScreen(),
                  child: const Text(
                    'Don\'t have account? Sign up',
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
