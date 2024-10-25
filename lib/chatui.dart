// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:mindos_2/provider/mainProvider.dart';
// import 'package:provider/provider.dart';
//
// class chatUIPage extends StatefulWidget {
//   const chatUIPage({super.key});
//
//   @override
//   State<chatUIPage> createState() => _chatUIPageState();
// }
//
// class _chatUIPageState extends State<chatUIPage> {
//
//   TextEditingController userInput = TextEditingController();
//   final apiKey = "AIzaSyCJoM-BbHlnwrf4V8fECEjFSC1cabHyErU";
//
//   Future<void> TalkWithGemnini()async {
//     final model = GenerativeModel(model: 'Gemini 1.5 Pro', apiKey: apiKey);
//
//     final msg = "write a quote about choclate";
//
//     final content = Content.text(msg);
//
//     final response = await model.generateContent([content]);
//     print("Response from Gemini AI : ${response.text}");
//
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           color: Colors.blueGrey.shade100,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//               Padding(
//                   padding: EdgeInsets.all(31),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 15,
//                       child: TextFormField(
//                         style: TextStyle(color: Colors.black),
//                         controller: userInput,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           label: Text("Enter Your Message..."),
//                         ),
//                       ),
//                     ),
//                     Spacer(),
//                     Consumer<MainProvider>(
//                       builder: (context, val,child) {
//                         return IconButton(
//                           padding: EdgeInsets.all(12),
//                             iconSize: 30,
//                             style: ButtonStyle(
//                               backgroundColor:  MaterialStateProperty.all(Colors.black),
//                               foregroundColor: MaterialStateProperty.all(Colors.white),
//                               shape: MaterialStateProperty.all(CircleBorder())
//                             ),
//                             onPressed: (){
//                               TalkWithGemnini();
//                             },
//                             icon: Icon(Icons.send));
//                       }
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
