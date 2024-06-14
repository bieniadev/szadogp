import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';
import 'package:szadogp/components/logo_appbar.dart';

class OptionsTerraformingMars extends StatefulWidget {
  const OptionsTerraformingMars({super.key});

  @override
  State<OptionsTerraformingMars> createState() => OptionsTerraformingMarsState();
}

class OptionsTerraformingMarsState extends State<OptionsTerraformingMars> {
  final _selected = BehaviorSubject<int>();
  final List<String> _wheelItems = const [
    'Default',
    'Hellas',
    'Elysium',
  ];
  String _result = '';

  @override
  void dispose() {
    _selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LogoAppbar(
        title: Image.asset('assets/images/logo.png', height: 30),
        customExitButton: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.chevron_left_rounded, size: 40),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Wylosuj planszę', style: GoogleFonts.rubik(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2)),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () => setState(() => _selected.add(Fortune.randomInt(0, _wheelItems.length))),
              child: SizedBox(
                height: 280,
                width: 280,
                child: FortuneWheel(
                  items: _wheelItems.map((name) => FortuneItem(child: Text(name, style: GoogleFonts.rubikMonoOne(letterSpacing: 1.5, fontSize: 14)))).toList(),
                  selected: _selected.stream,
                  animateFirst: false,
                  onAnimationEnd: () => setState(() => _result = _wheelItems[_selected.value]),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Wylosowano: $_result', style: GoogleFonts.rubik(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 1)),
          ],
        ),
      ),
    );
  }
}
