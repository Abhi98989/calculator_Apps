// import 'package:flutter/material.dart';

// class StorageScreen extends StatelessWidget {
//   final List<String> calculationHistory;

//   const StorageScreen({Key? key, required this.calculationHistory}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('History'),
//       ),
//       body: calculationHistory.isEmpty
//           ? const Center(child: Text("No History Available"))
//           : ListView.builder(
//               itemCount: calculationHistory.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(calculationHistory[index]),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.delete),
//                     onPressed: () {
//                       // Optionally, add functionality to remove a history entry
//                     },
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
