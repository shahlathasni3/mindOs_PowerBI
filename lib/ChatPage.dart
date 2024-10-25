import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mindos_2/homePage.dart';
import 'package:mindos_2/provider/mainProvider.dart';
import 'package:o3d/o3d.dart';
import 'package:provider/provider.dart';
import 'api/apis.dart';
import 'models/ChatUser.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key,});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late FlutterTts flutterTts = FlutterTts();
  O3DController o3dController = O3DController();
  List<ChatUser> list = [];
  final Gemini gemini = Gemini.instance;
  ScrollController _scrollController = ScrollController();



  @override
  Widget build(BuildContext context) {
    // Define mq as MediaQuery
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1578CA), // Set the background color
        elevation: 0,
        leading: Consumer<MainProvider>(
          builder: (context,a,child) {
            return IconButton(
              icon: Icon(Icons.arrow_back,color: Colors.white,),
              onPressed: () async {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                // Clear the TextField after sending
                for(var i in a.streamAnswer){
                  await flutterTts.speak(i);
                }
                a.streamAnswer.clear();
              },
            );
          }
        ),

        title: Center(
              child: Text(
                'mindOs',
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 21,
                  fontWeight: FontWeight.bold,// Font size
                ),
              ),
            ),
        actions: [
          // PowerBI Button
          Row(
            children: [
              // IconButton(
              //     onPressed: () {
              //       // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => profileScreen(user: APIs.me,)));
              //     },
              //     icon: const Icon(Icons.more_vert,color: Colors.white,)
              // ),

              IconButton(
                icon: Icon(Icons.stop_circle_outlined,color: Colors.white,),
                onPressed: () async {
                  await flutterTts.stop();
                },
              ),

              Consumer<MainProvider>(
                builder: (context, val12, child) {
                  return IconButton(
                    icon: Icon(Icons.play_circle_fill_outlined,color: Colors.white,),
                    onPressed: () async {
                      for(var i in val12.streamAnswer){
                        await flutterTts.speak(i);
                      }

                    },
                  );
                }
              ),
            ],
          ),
        ],
      ),
      body:Consumer<MainProvider>(
        builder: (context, value100, child) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            // height: mq.height * 1.5,
            width: mq.width,
            decoration: BoxDecoration(
              color: Color(0xFFFCF7F7),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 24, right: 15),
              child: Container(
                // height: height * 0.474,
                width: mq.width * 0.879,
                decoration: BoxDecoration(
                    color: Color(0xFF1578CA),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(25))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 13, left: 13),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: value100.streamAnswer.length, // Set this to the number of items you want to display
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0), // Add padding for better UI
                        child: Text(
                          value100.streamAnswer[index], // Assuming streamAnswer is a string
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xffffffff),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ), // Add body content here
      bottomNavigationBar: Consumer<MainProvider>(
        builder: (context,value120,child) {
          return Container(
            height: mq.height*.13,
            decoration: BoxDecoration(
              color: Color(0xFFA7CDE9),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 15,
                    bottom: 20,
                  ),
                  child: Container(
                    height: mq.height * 0.06,
                    width: mq.width * 0.71,
                    decoration: BoxDecoration(
                        color: Color(0xFF1578CA),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 7, top: 5),
                      child: TextField(
                        controller: value120.controller,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          hintText: 'Enter a prompt here...',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,bottom: 11),
                  child: Consumer<MainProvider>(
                    builder: (context,value10,child) {
                      return InkWell(

                        onTap: () async {
                          // value10.geminiStream(value120.controller.text);

                          // Get the message from the TextField
                          final message = value120.controller.text.trim();

                          if (message.isNotEmpty) {
                            // Save the chat data to Firestore
                            await APIs().saveChatData(message);

                            // Clear the TextField after sending
                            value120.controller.clear();

                            // Clear the streamAnswer after click send for another question
                            value10.streamAnswer.clear();
                            // Call the Gemini stream function to get a response
                            value120.geminiStream(message);
                          }
                        },

                        child: Container(
                          height: mq.height * 0.06,
                          width: mq.width * 0.145,
                          decoration: BoxDecoration(
                              color: Color(0xFF1578CA),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Icon(
                              Icons.send,
                              color: Color(0xffffffff),
                              // size: height * 0.035,
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}




// custom gemini
// final TextEditingController _controller = TextEditingController();
// String _response = "";
//
// // Replace this URL with your Cloud Run service URL
// final String cloudRunUrl = "https://gen-ai-cloud-run-xyz.a.run.app/generate";
//
// // Function to call the Cloud Run service
// Future<void> getAIResponse(String userInput) async {
//   final Map<String, dynamic> requestBody = {
//     "input": userInput,
//   };

// try {
//   final response = await http.post(
//     Uri.parse(cloudRunUrl),
//     headers: {"Content-Type": "application/json"},
//     body: jsonEncode(requestBody),
//   );
//
//   if (response.statusCode == 200) {
//     final Map<String, dynamic> responseData = json.decode(response.body);
//     setState(() {
//       _response = responseData['response'];
//     });
//   } else {
//     setState(() {
//       _response = "Error: Unable to get a response";
//     });
//   }
// } catch (e) {
//   setState(() {
//     _response = "Error: $e";
//   });
// }
// }