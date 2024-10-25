// import 'package:cloud_firestore/cloud_firestore.dart';

// class FirestoreService {
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//
//   Future<void> addKnowledgeBaseEntry(String question, String answer) {
//     return db.collection('knowledge_base').add({
//       'question': question,
//       'answer': answer,
//     });
//   }
//
//   Future<List<Map<String, dynamic>>> getKnowledgeBase() async {
//     final snapshot = await db.collection('knowledge_base').get();
//     return snapshot.docs.map((doc) => doc.data()).toList();
//   }
// }
