import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/models/user_model.dart';
import 'package:szadogp/providers/current_user_data.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(currentUserDataProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Home', selectionColor: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            children: [
              const Text('SIEMANOO'),
              userData.when(
                data: (userData) {
                  List<UserData> info = userData.map((e) => e).toList();
                  return Expanded(
                      child: ListView.builder(
                    itemCount: info.length,
                    itemBuilder: (_, index) {
                      return Card(
                        color: Colors.red,
                        child: ListTile(
                          title: Text(info[index].firstname),
                          subtitle: Text(info[index].id.toString()),
                          trailing: CircleAvatar(
                            backgroundImage: NetworkImage(info[index].avatar),
                          ),
                        ),
                      );
                    },
                  ));
                },
                error: (err, s) => Text(
                  err.toString(),
                ),
                loading: (() => const CircularProgressIndicator()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
