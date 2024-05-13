import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/models/test.dart';
import 'package:szadogp/providers/ranking.dart';

class SelectRanking extends ConsumerStatefulWidget {
  const SelectRanking({super.key, required this.players});

  final List<TeamGroups> players;
  @override
  ConsumerState<SelectRanking> createState() => _SelectRankingState();
}

class _SelectRankingState extends ConsumerState<SelectRanking> {
  List<TeamGroups> _players = [];
  final List<Ranking> _rankings = [];
  final List<int?> _groupValue = [];

  @override
  void initState() {
    super.initState();
    _players = widget.players;

    for (var i = 0; i < _players.length; i++) {
      _groupValue.add(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48 * _players.length.toDouble() +
          (_players.length.toDouble() * 10) -
          10,
      child: ListView.separated(
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _players.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          List<UserInfo> usersInfo = _players[index].users;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('TEAM ${index + 1}'),
              const SizedBox(width: 12),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: usersInfo.length,
                  itemBuilder: (context, index) {
                    return Text(usersInfo[index].username);
                  },
                ),
              ),
              const SizedBox(width: 8),
              DropdownButton<int>(
                  value: _groupValue[index],
                  items: List.generate(
                      5, // to do: przy dynamicznym renderowanu itemow wywala err  zmienna-> _lobbyData['users'].length
                      (index) => DropdownMenuItem<int>(
                            value: index + 1,
                            child: Text('NR: ${index + 1}'),
                          )),
                  onChanged: (value) {
                    setState(() {
                      _groupValue[index] = value!;
                    });

                    Ranking selectedRank = Ranking(
                        groupIdentifier: index + 1, place: _groupValue[index]!);
                    _rankings.add(selectedRank);
                    int rankIndex = 0;
                    for (var rank in _rankings) {
                      if (selectedRank.groupIdentifier ==
                              rank.groupIdentifier &&
                          _rankings.length > _players.length) {
                        break;
                      }
                      rankIndex++;
                    }
                    if (_rankings.length > _players.length) {
                      _rankings.removeAt(rankIndex);
                    }

                    ref.read(rankingProvider.notifier).state = _rankings;
                  }),
            ],
          );
        },
      ),
    );
  }
}
