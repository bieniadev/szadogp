import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:szadogp/models/models_summary_screen.dart';
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
      height: 60 * _players.length.toDouble() + (_players.length.toDouble() * 10) - 10,
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
                    return Text(
                      usersInfo[index].username,
                      style: GoogleFonts.rubik(fontSize: 14),
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              DropdownButton<int>(
                  value: _groupValue[index],
                  padding: const EdgeInsets.all(0),
                  borderRadius: BorderRadius.circular(12),
                  dropdownColor: Theme.of(context).colorScheme.background,
                  icon: const SizedBox(height: 0, width: 0),
                  underline: const SizedBox(height: 0, width: 0),
                  hint: const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(Icons.arrow_drop_down_circle, color: Colors.white, size: 40),
                  ),
                  itemHeight: 60,
                  items: List.generate(
                      _players.length,
                      (index) => DropdownMenuItem<int>(
                            value: index + 1,
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/${index + 1}_miejsce.png'))),
                            ),
                          )),
                  onChanged: (value) {
                    setState(() {
                      _groupValue[index] = value!;
                    });

                    Ranking selectedRank = Ranking(groupIdentifier: index + 1, place: _groupValue[index]!);
                    _rankings.add(selectedRank);
                    int rankIndex = 0;
                    for (var rank in _rankings) {
                      if (selectedRank.groupIdentifier == rank.groupIdentifier && _rankings.length > _players.length) {
                        break;
                      }
                      rankIndex++;
                    }
                    if (_rankings.length > _players.length) {
                      _rankings.removeAt(rankIndex);
                    }

                    _rankings.sort((a, b) => a.groupIdentifier.compareTo(b.groupIdentifier));

                    ref.read(rankingProvider.notifier).state = _rankings;
                  }),
            ],
          );
        },
      ),
    );
  }
}
