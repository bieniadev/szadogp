import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SelectRanking extends StatefulWidget {
  const SelectRanking({super.key, required this.players});

  final List<dynamic> players;

  @override
  State<SelectRanking> createState() => _SelectRankingState();
}

class _SelectRankingState extends State<SelectRanking> {
  List<dynamic> _players = [];
  String _dropDownValue = '';

  void dropDownCallBack(String? selectedVal) {
    if (selectedVal is String) {
      setState(() {
        _dropDownValue = selectedVal;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _players = widget.players;
  }

  @override
  Widget build(BuildContext context) {
    print('PLAYERSJI: ${_players[0]}');
    int index = 1;
    for (var player in _players) {
      print('DRUZYNA $index GRACZE: $player');
      index++;
    }
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: _players.length,
        itemBuilder: (context, index) {
          final places = List.filled(_players.length, index);
          print(places);
          return Row(
            children: [
              Text('DRUŻYNA ${index + 1}'),
              DropdownButton(
                items: const [
                  DropdownMenuItem(
                    child: Text('kys'),
                    value: '2',
                  ),
                  DropdownMenuItem(
                    child: Text('kys'),
                    value: '2',
                  )
                ],
                onChanged: dropDownCallBack,
              ),
            ],
          );
        },
      ),
    );
    // return DropdownButton(items: , onChanged: onChanged);
    // return Text('kys');
  }
}
