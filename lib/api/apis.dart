import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../models/ChatUser.dart';

class APIs {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  // for storing self information
  static late ChatUser me;
  // to return current user
  static User get user => auth.currentUser!;

  // for checking if user exists or not
  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  // for getting current user info
  static Future<void> getSelfInfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  // for creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final formattedTime = DateTime.now().toIso8601String(); // ISO format

    final chatUser = ChatUser(
      id: user.uid,
      name: user.displayName.toString(),
      email: user.email.toString(),
      about: "Hey, I am using ChatNest",
      image: user.photoURL.toString(),
      createdAt: time,
      isOnline: true,
      lastActive: time,
      pushToken: '',
      loginTime: formattedTime,
      logoutTime: '', // Will be updated later on logout
    );

    return await firestore.collection('users').doc(user.uid).set(chatUser.toJson());
  }

  // for updating user information
  static Future<void> updateUserInfo() async {
    await firestore.collection('users').doc(user.uid).update({
      'name': me.name,
      'about': me.about,
      'login_time': me.loginTime,
      'logout_time': me.logoutTime,
      'total_duration': me.totalDuration,
    });
  }

  // for getting all users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore.collection('users').where('id', isNotEqualTo: user.uid).snapshots();
  }

  // Create the "People Chatting Report"
  Future<void> saveChatData(String message) async {
    DateTime now = DateTime.now();
    String id = now.millisecondsSinceEpoch.toString();

    // Assume using Firebase Firestore
    await FirebaseFirestore.instance.collection('chat_reports').doc(id).set({
      'message': message,
      'timestamp': now,
      'sender': user.displayName,
    }, SetOptions(merge: true));
  }

  // for logging out the user and updating logoutTime and totalDuration
  static Future<void> logoutUser() async {
    final logoutTime = DateTime.now().toIso8601String();

    // Update `me` object
    me.logoutTime = logoutTime;

    // Calculate total duration
    me.totalDuration = _calculateDuration();

    // Update Firestore with new logoutTime and totalDuration
    await firestore.collection('users').doc(user.uid).update({
      'logout_time': logoutTime,
      'total_duration': me.totalDuration,
      'is_online': false,
    });

    await auth.signOut();
  }

  // Helper function to calculate total duration (can be moved to ChatUser class if needed)
  static String _calculateDuration() {
    if (me.loginTime.isEmpty || me.logoutTime.isEmpty) return '0';

    DateTime login = DateTime.parse(me.loginTime);
    DateTime logout = DateTime.parse(me.logoutTime);

    Duration duration = logout.difference(login);
    return duration.toString(); // You can format this as needed (hours/minutes/seconds)
  }



  // Future<void> extractTextFromPdf(String pdfPath) async {
  //   try {
  //     // Load the PDF document
  //     PDFDoc doc = await PDFDoc.fromPath(pdfPath);
  //
  //     // Extract text from the PDF document
  //     String text = await doc.text;
  //
  //     // Print or send the extracted text to Gemini or any other service
  //     print(text);
  //     // You can integrate sending this text to Gemini or any other AI here
  //   } catch (e) {
  //     // Handle potential errors, such as if the PDF file is corrupted or not found
  //     print('Error extracting text from PDF: $e');
  //   }
  // }



}
