import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:szadogp/screens/home.dart';
import 'package:szadogp/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) => runApp(const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STart Ap',
      theme: themeDark,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
