import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mindos_2/api/apis.dart';
import 'package:mindos_2/contWithGoogle.dart';
import 'package:mindos_2/models/ChatUser.dart';
import 'package:mindos_2/profileScreen.dart';
import 'package:mindos_2/reports/PowerBIReportScreen.dart';
import 'chat_user_card.dart';

class HomeScreen extends StatefulWidget {
  final User? user;
  const HomeScreen({super.key, this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<ChatUser> list =[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(onTap : (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> contWithGoogle()));
          },child: const Icon(CupertinoIcons.home)),
        title: Text("mindOs",style: TextStyle(
                  color: Colors.blueAccent, // Text color
                  fontSize: 21,
                  fontWeight: FontWeight.bold,// Font size
                ),),
        actions: [
              // PowerBI Button
              Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => PowerBIReportButton()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Button background color
                          foregroundColor: Colors.white, // Button text color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // Rounded corners
                          ),
                        ),
                        child: Text('PowerBI'),
                      ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => profileScreen(user: list[0],)));
                  },
                  icon: const Icon(Icons.more_vert,color: Colors.blue,)),

        ],
      ),

      // floating button to add new user
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 15, bottom: 15),
        child: FloatingActionButton(
          onPressed: () async {
            await APIs.auth.signOut();
            await GoogleSignIn().signOut();
          },
          child: const Icon(Icons.add_comment_rounded),
        ),
      ),
      body: StreamBuilder(
        stream: APIs.firestore.collection('users').snapshots(),
        builder: (context, snapshot){
          // final list =[];
          switch(snapshot.connectionState){
            // if data is loading
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator(),);

              // if some or all data is loaded then show it
            case ConnectionState.active:
            case ConnectionState.done:
                  final data = snapshot.data?.docs;
                  // for(var i in data!){
                  //   print('Dta : ${jsonEncode(i.data())}');
                  //   list.add(i.data()['name']);
                  // }
                  list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
                  return ListView.builder(
                    itemCount: list.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index){
                      return chat_user_card(user: list[index],);
                      // return Text('name : ${list[index]}');
                    });
          }

        },
      ),
    );
  }
}