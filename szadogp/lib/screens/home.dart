import 'package:flutter/material.dart';
import 'package:szadogp/components/action_button.dart';
import 'package:szadogp/components/input_code.dart';
import 'package:szadogp/components/user_panel.dart';
import 'package:szadogp/screens/select_game.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final _codeController = TextEditingController();
bool _isCodeFull = false;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    void swapButtonsHandler(value) {
      if (value.length == 6) {
        setState(() {
          _isCodeFull = true;
        });
      } else if (value.length < 6 && _isCodeFull == true) {
        setState(() {
          _isCodeFull = false;
        });
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserPanel(),
            const SizedBox(height: 150),
            Image.asset('assets/images/logo.png'),
            const SizedBox(height: 60),
            const Spacer(),
            //create game / join game buttons
            !_isCodeFull
                ? ActionButton(
                    hintText: 'STWÓRZ GRĘ',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SelectGameScreen(),
                      ));
                    })
                : ActionButton(
                    hintText: 'DOŁĄCZ DO GRY',
                    onTap: () {
                      // kod dolaczajacy do gry i laczy sie z api
                    },
                  ),
            const Spacer(),
            //6 digit code input for join
            CodeInput(
              controller: _codeController,
              onChanged: swapButtonsHandler,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
