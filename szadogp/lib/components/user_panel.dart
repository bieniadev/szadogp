import 'package:flutter/material.dart';

class UserPanel extends StatelessWidget {
  const UserPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 47, 41, 60),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0)),
      ),
      child: const Padding(
        padding: EdgeInsets.all(25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 30,
            ),
            Text('USERNAME', style: TextStyle(fontSize: 22)),
            SizedBox(width: 60)
          ],
        ),
      ),
    );
  }
}
