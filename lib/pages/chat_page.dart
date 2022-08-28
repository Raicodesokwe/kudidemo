import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> _chatStream = FirebaseFirestore.instance
      .collection('chats/mQyAl8lQj4M7LufEZWjn/messages')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection('chats/mQyAl8lQj4M7LufEZWjn/messages')
                .add({'text': 'nitakutichi'});
          },
          child: Icon(Icons.add),
        ),
        body: StreamBuilder(
          stream: _chatStream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return Text(data['text']);
            }).toList());
          },
        ));
  }
}
