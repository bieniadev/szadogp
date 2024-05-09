import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
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
final _localUserToken = Hive.box('token');

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
                      if (_codeController.text == 'secret' ||
                          _codeController.text == 'SECRET') {
                        _localUserToken.put(
                            1, 'gie3tm4oaaigmkaKAOpeo3920J8382');
                        print('dodano TOKEN do lokalnej bazy');
                      }
                      if (_codeController.text == 'czytaj' ||
                          _codeController.text == 'CZYTAJ') {
                        String localToken = _localUserToken.get(1);
                        print('wyswietlono TOKEN z lokalnej bazy: $localToken');
                      }
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
