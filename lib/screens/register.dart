import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive/hive.dart';
import 'package:szadogp/components/input_textfield.dart';
import 'package:szadogp/components/submit_button.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/providers/is_loading.dart';
import 'package:szadogp/screens/login.dart';
import 'package:szadogp/services/services.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // controlers for texfield inputs
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    //regiser user method
    registerUser(WidgetRef ref) async {
      //read inputs from controlers
      final String password = passwordController.text;
      final String email = emailController.text;
      final String username = usernameController.text;

      try {
        //call request
        final response = await ApiServices().registerCredentials(email, password, username);

        if (response) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            content: Text('Udało się założyć konto!,'),
            backgroundColor: Colors.green,
          ));

          ref.read(isLoadingProvider.notifier).state = false;
          //set current screen to loginscreen;
          ref.read(currentScreenProvider.notifier).state = const LoginScreen();
        }
      } catch (err) {
        ref.read(isLoadingProvider.notifier).state = false;
        // ignore: use_build_context_synchronously
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 5),
          content: Text('$err, Spróbuj użyć hasła: Password1!as'),
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
                const SizedBox(height: 68),

                //login input
                InputTextfield(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 15),

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
                    registerUser(ref);
                  },
                  hintWidget: const Text(
                    'Create account',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2),
                  ),
                ),
                const SizedBox(height: 40),

                // create account click text
                GestureDetector(
                  onTap: () => ref.read(currentScreenProvider.notifier).state = const LoginScreen(),
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
