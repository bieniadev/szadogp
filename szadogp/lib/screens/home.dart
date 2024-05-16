import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/components/action_button.dart';
import 'package:szadogp/components/lobby/input_code.dart';
import 'package:szadogp/components/user-stats/user_panel.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/providers/is_loading.dart';
import 'package:szadogp/providers/lobby.dart';
import 'package:szadogp/screens/lobby.dart';
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

    // Map<String, dynamic> userInfo = ref.read(userInfoProvider);

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
                      hasBorder: true,
                      onTap: () {
                        ref.read(isLoadingProvider.notifier).state = false;
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SelectGameScreen()));
                      })
                  : ActionButton(
                      hintText: 'DOŁĄCZ DO GRY',
                      hasBorder: true,
                      onTap: () async {
                        //unfocus keyboard
                        FocusManager.instance.primaryFocus?.unfocus();

                        // //usunac w produkcji ok?
                        // if (_codeController.text.toLowerCase() == 'delete') {
                        //   // to do: wylogowanie? przykladowy kod
                        //   _dbRef.delete(1);
                        //   ref.read(userTokenProvider.notifier).state = '';
                        //   ref.read(currentScreenProvider.notifier).state = const LoginScreen();
                        //   ref.read(isLoadingProvider.notifier).state = false;
                        // }

                        // kod dolaczajacy do gry i laczy sie z api
                        try {
                          final lobbyData = await ApiServices().joinGame(_codeController.text.toUpperCase());
                          ref.read(lobbyDataProvider.notifier).state = lobbyData;
                          ref.read(isLoadingProvider.notifier).state = false;
                          ref.read(currentScreenProvider.notifier).state = const LobbyScreen();
                        } catch (err) {
                          ref.read(isLoadingProvider.notifier).state = false;
                          // ignore: use_build_context_synchronously
                          return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(seconds: 3),
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
