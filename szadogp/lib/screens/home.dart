import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:szadogp/components/action_button.dart';
import 'package:szadogp/components/input_code.dart';
import 'package:szadogp/components/user_panel.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/providers/lobby.dart';
import 'package:szadogp/providers/user_token.dart';
import 'package:szadogp/screens/lobby.dart';
import 'package:szadogp/screens/login.dart';
import 'package:szadogp/screens/select_game.dart';
import 'package:szadogp/services/services.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _codeController = TextEditingController();
  bool _isCodeFull = false;
  final _dbRef = Hive.box('user-token');

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const UserPanel(),
              const SizedBox(height: 150),
              Image.asset('assets/images/logo.png'),
              const SizedBox(height: 60),
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
                      onTap: () async {
                        //unfocus keyboard
                        FocusManager.instance.primaryFocus?.unfocus();

                        //usunac w produkcji ok?
                        if (_codeController.text.toLowerCase() == 'delete') {
                          //wylogowanie? przykladowy kod
                          _dbRef.delete(1);
                          ref.read(userTokenProvider.notifier).state = '';
                          ref.read(currentScreenProvider.notifier).state = const LoginScreen();
                        }

                        // kod dolaczajacy do gry i laczy sie z api
                        try {
                          final lobbyData = await ApiServices().joinGame(_codeController.text);
                          ref.read(lobbyDataProvider.notifier).state = lobbyData;
                          ref.read(currentScreenProvider.notifier).state = const LobbyScreen();
                        } catch (err) {
                          // ignore: use_build_context_synchronously
                          return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(seconds: 5),
                            content: Text('$err'),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                    ),
              const SizedBox(height: 60),

              //6 digit code input for join
              CodeInput(
                controller: _codeController,
                onChanged: swapButtonsHandler,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
