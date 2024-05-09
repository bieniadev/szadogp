import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/components/logo_appbar.dart';

class SelectGameScreen extends ConsumerWidget {
  const SelectGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //wyslanie kody do api z wybrana gra i po sukcesie stworzenie pokoju i przejscie do jego ekranu
    void selectGame(index) {
      print('Wybrales nr: ${index + 1}');
    }

    return Scaffold(
      appBar: const LogoAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: 7, // list.length from data base
          itemBuilder: (context, index) => GestureDetector(
            //on select game function
            onTap: () => selectGame(index),
            child: Card(
              color: Colors.grey,
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              clipBehavior: Clip.hardEdge,
              elevation: 10,
              child: SizedBox(
                height: 150,
                child: Image.network(
                    fit: BoxFit.fill,
                    'https://m.media-amazon.com/images/S/aplus-media-library-service-media/3a7bd0d7-a284-43b3-b49c-be698bda066a.__CR0,0,970,300_PT0_SX970_V1___.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
