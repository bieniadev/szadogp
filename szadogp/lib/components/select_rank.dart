import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectRanking extends ConsumerStatefulWidget {
  const SelectRanking({super.key, required this.players});

  final List<dynamic> players;

  @override
  ConsumerState<SelectRanking> createState() => _SelectRankingState();
}

class _SelectRankingState extends ConsumerState<SelectRanking> {
  List<dynamic> _players = [];

//   int _inGameTeams = 0; , naprawic dynamicznie renderowana ilosc miejsc lol??

  @override
  void initState() {
    super.initState();
    _players = widget.players;
    // _inGameTeams = _players.length; , naprawic dynamicznie renderowana ilosc miejsc lol??
  }

  @override
  Widget build(BuildContext context) {
    // print(_inGameTeams); , naprawic dynamicznie renderowana ilosc miejsc lol??
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: _players.length,
        itemBuilder: (context, index) {
          List<int> dropDownValue = List.generate(_players.length, (index) => index + 1);

          // SaveToSend (){
          //     ref.read().state = ;
          // }

          //   print('LISTA Z VALUES: ${_players[index]['users']}');

          List<DropdownMenuItem<int>>? lista = List.generate(
              5, // _inGameTeams, naprawic dynamicznie renderowana ilosc miejsc lol??
              (index) => DropdownMenuItem(
                    value: index,
                    child: Text('${index + 1}'),
                  ));
          // .map((e) => DropdownMenuItem(
          //       value: index,
          //       child: Text(e['groupIdentifier'].toString()),
          //     ))
          // .toList();
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text('DRUŻYNA ${index + 1}'),
                  Builder(
                    builder: (context) {
                      List<dynamic> usersInGroup = _players[index]['users'];
                      List<dynamic> userNickname = usersInGroup.map((e) => e['username']).toList();

                      for (var nickname in userNickname) {
                        return Text(nickname);
                      }
                      return const Text('blad');
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              DropdownButton(
                hint: const Text('Wybierz miejsce'),
                value: dropDownValue[index],
                items: lista,
                onChanged: (int? selectedVal) {
                  setState(() {
                    dropDownValue[index] = selectedVal! - 1;
                  });
                },
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
