import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  // ignore: unused_local_variable
  var db = await Hive.openBox('user-token');

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(const ProviderScope(child: App())));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 's.z.a.do gp',
      theme: themeDark,
      debugShowCheckedModeBanner: false,
      home: ref.watch(currentScreenProvider),
    );
  }
}
