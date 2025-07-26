import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsers() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();

        return user;

      }).toList();
    });
  }

  Future<void> sendMessage(String receiverID, message) async {
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    List<String> chatIDs = [currentUserID, receiverID];
    chatIDs.sort(); // Ensure consistent order
    String chatID = chatIDs.join('_');

    await _firestore.collection('chats').doc(chatID).collection('messages').add(newMessage.toMap());
  }

  // ignore: non_constant_identifier_names
  Stream<QuerySnapshot> getMessages(String UserID, otherUserID) {
    List<String> chatIDs = [UserID, otherUserID];
    chatIDs.sort(); // Ensure consistent order
    String chatID = chatIDs.join('_');

    return _firestore.collection('chats').doc(chatID).collection('messages').orderBy('timestamp', descending: false).snapshots();
  } 
}