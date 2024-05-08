import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/components/action_button.dart';
import 'package:szadogp/components/input_code.dart';
import 'package:szadogp/components/user_panel.dart';
import 'package:szadogp/providers/login_user.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final userProvider = ref.watch(loginUserProvider);

    final codeController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserPanel(),
            const SizedBox(height: 250),
            Image.asset('assets/images/logo.png'),
            const SizedBox(height: 60),
            const Spacer(),
            ActionButton(onTap: () {}, hintText: 'STWÓRZ GRĘ'),
            const Spacer(),
            CodeInput(controller: codeController),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}



// userProvider.when(
//   data: (userResponse) {
//     String userToken = userResponse;
//     return Text('Twój poufny token: $userToken');
//   },
//   error: (err, s) => Text(
//     err.toString(),
//   ),
//   loading: (() => const CircularProgressIndicator()),
// )
