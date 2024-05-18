import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:szadogp/providers/selected_image.dart';
import 'package:szadogp/providers/user_data.dart';
import 'package:szadogp/providers/user_stats.dart';
import 'package:szadogp/screens/user_stats.dart';
import 'package:szadogp/services/services.dart';

class UserPanel extends ConsumerStatefulWidget {
  const UserPanel({super.key});

  @override
  ConsumerState<UserPanel> createState() => _UserPanelState();
}

class _UserPanelState extends ConsumerState<UserPanel> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider);

    return userData.when(
      data: (userInfo) {
        Hive.box('user-token').put(2, userInfo);
        return _isLoading
            ? Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 51, 51, 53),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0), bottomRight: Radius.circular(50.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: ref.watch(selectedImageProvider) == null
                            ? const Icon(Icons.account_circle_rounded, size: 60, color: Colors.black38)
                            : Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(width: 1, color: Colors.black),
                                    image: DecorationImage(
                                      image: MemoryImage(ref.watch(selectedImageProvider)!),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                      ),
                      const CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                      const SizedBox(width: 60)
                    ],
                  ),
                ),
              )
            : GestureDetector(
                onTap: () async {
                  ref.read(userInfoProvider.notifier).state = userInfo;
                  setState(() => _isLoading = true);

                  try {
                    final List<dynamic> response = await ApiServices().getUserStats();
                    ref.read(testUserStatsProvider.notifier).state = response;
                  } catch (err) {
                    setState(() => _isLoading = false);
                    throw Exception('$err');
                  }

                  setState(() => _isLoading = false);
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserStatsScreen()));
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 51, 51, 53),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0), bottomRight: Radius.circular(50.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          child: ref.watch(selectedImageProvider) == null
                              ? const Icon(Icons.account_circle_rounded, size: 60, color: Colors.black38)
                              : Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(width: 1, color: Colors.black),
                                      image: DecorationImage(
                                        image: MemoryImage(ref.watch(selectedImageProvider)!),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                        ),
                        Text(userInfo['username'], style: GoogleFonts.comicNeue(fontSize: 26, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 60)
                      ],
                    ),
                  ),
                ),
              );
      },
      loading: () => Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 51, 51, 53),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0), bottomRight: Radius.circular(50.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 30,
                child: ref.watch(selectedImageProvider) == null
                    ? const Icon(Icons.account_circle_rounded, size: 60, color: Colors.black38)
                    : Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(width: 1, color: Colors.black),
                            image: DecorationImage(
                              image: MemoryImage(ref.watch(selectedImageProvider)!),
                              fit: BoxFit.cover,
                            )),
                      ),
              ),
              Text('Wczytywanie...', style: GoogleFonts.comicNeue(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(width: 60)
            ],
          ),
        ),
      ),
      error: (err, stackTrace) => Text('Błąd: $err'),
    );
  }
}
