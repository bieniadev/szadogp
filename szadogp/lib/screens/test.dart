// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class TestScr extends StatefulWidget {
//   const TestScr({super.key});

//   @override
//   State<TestScr> createState() => _TestScrState();
// }

// class _TestScrState extends State<TestScr> {
//   List<DropdownMenuItem<String>> _listaItemow = [
//     DropdownMenuItem(child: Text('jeden'), value: 'jeden'),
//     DropdownMenuItem(child: Text('dwa'), value: 'dwa'),
//     DropdownMenuItem(child: Text('trzy'), value: 'trzy'),
//   ];

// //   String _resultValue = 'lol';

//   String? _resultValue;
//   @override
//   void initState() {
//     super.initState();
//     // _resultValue = 'dog';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             const SizedBox(height: 200),
//             const Text('elo'),
//             DropdownButton(
//               items: _listaItemow,
//               onChanged: (value) {
//                 setState(() {
//                   if (value is String) {
//                     _resultValue = value;
//                   }
//                 });
//                 print(_resultValue);
//               },
//               hint: const Text('kyts'),
//               value: _resultValue,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
