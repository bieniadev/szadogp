import 'package:flutter/material.dart';
// import 'package:szadogp/services/services.dart';

class OnTapPopups {
  Future<void> removeUserFromLobby(
      BuildContext context, String name, String userId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to continue action
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Usuń z lobby',
            style: TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Czy napewno chcesz usunąć z lobby $name'),
                Text('ID USERA: $userId')
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Anuluj',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text(
                'Usuń',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();

                //api call do usuwanie usera z lobby
                // ApiServices().deleteUserFromLobby(userId);
              },
            ),
          ],
        );
      },
    );
  }
}
