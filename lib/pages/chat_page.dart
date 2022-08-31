import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../theme/concavedecoration.dart';
import '../theme/seconddecoration.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final Stream<QuerySnapshot> _chatStream;
  late final Future<DocumentSnapshot<Map<String, dynamic>>> _usernameFuture;

  TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    _chatStream = FirebaseFirestore.instance
        .collection('chats')
        .orderBy('createdAt', descending: true)
        .snapshots();
    _usernameFuture =
        FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
    super.initState();
  }

  var _enteredMsg = '';
  User? user = FirebaseAuth.instance.currentUser;
  late bool isMe;
  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeProvider>(context).darkTheme;
    final BoxDecoration decorator = BoxDecoration(
      boxShadow: themeData
          ? [
              BoxShadow(
                  color: Colors.grey.shade500,
                  offset: Offset(4, 4),
                  blurRadius: 15,
                  spreadRadius: 1),
              BoxShadow(
                spreadRadius: 1,
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 15,
              )
            ]
          : [
              BoxShadow(
                  color: Colors.black,
                  offset: Offset(5, 5),
                  blurRadius: 15,
                  spreadRadius: 5),
              BoxShadow(
                spreadRadius: 1,
                color: Colors.grey.shade800,
                offset: Offset(-4, -4),
                blurRadius: 15,
              )
            ],
    );
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
          child: Container(
            height: 70,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, top: 10),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Center(
                            child: Image.asset(
                          'assets/images/cat.png',
                          scale: 2,
                        )),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          border: Border.all(
                            color: Colors.black,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Erick')
                    ],
                  ),
                ],
              ),
            ),
            decoration: themeData
                ? SecondDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    depression: 10,
                    colors: [Color.fromRGBO(216, 213, 208, 1), Colors.white])
                : ConcaveDecoration(
                    colors: [Colors.black, Colors.grey.shade800],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    depression: 10),
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: _chatStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView(
                  reverse: true,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    isMe = data['userId'] == user!.uid;

                    return Stack(
                      children: [
                        Row(
                          mainAxisAlignment: isMe
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Container(
                                width: 140,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 2, bottom: 8),
                                decoration: decorator.copyWith(
                                    color: isMe
                                        ? Colors.black
                                        : themeData
                                            ? Colors.grey[300]
                                            : Colors.grey[900],
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                        bottomLeft: !isMe
                                            ? Radius.circular(0)
                                            : Radius.circular(12),
                                        bottomRight: isMe
                                            ? Radius.circular(0)
                                            : Radius.circular(12))),
                                child: Column(
                                  crossAxisAlignment: isMe
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['username'],
                                      style: GoogleFonts.prompt(
                                          color: isMe && themeData
                                              ? Colors.white70
                                              : Colors.black54),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      data['text'],
                                      style: TextStyle(
                                          color: isMe
                                              ? Colors.white
                                              : themeData
                                                  ? Colors.black
                                                  : Colors.white),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        Positioned(
                          top: -20,
                          left: isMe ? null : 120,
                          right: isMe ? 120 : null,
                          child: Container(
                            height: 40,
                            width: 40,
                            child: data['image_url'] == null
                                ? Center(
                                    child: Image.asset(
                                    'assets/images/puppy.png',
                                    scale: 2,
                                  ))
                                : Container(),
                            decoration: data['image_url'] == null
                                ? BoxDecoration(
                                    color: Colors.greenAccent,
                                    shape: BoxShape.circle,
                                  )
                                : BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            NetworkImage(data['image_url']))),
                          ),
                        ),
                      ],
                      clipBehavior: Clip.none,
                    );
                  }).toList());
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: decorator.copyWith(
                        color: themeData ? Colors.grey[300] : Colors.grey[900],
                        borderRadius: BorderRadius.circular(10.0)),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _enteredMsg = value;
                        });
                      },
                      controller: _messageController,
                      cursorColor: Colors.black45,
                      decoration: InputDecoration(
                          hintText: 'Send a message . . .',
                          hintStyle: GoogleFonts.prompt(),
                          border: InputBorder.none),
                    )),
              ),
              _enteredMsg.trim().isEmpty || _messageController.text.isEmpty
                  ? Container()
                  : GestureDetector(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        final DocumentSnapshot _userData =
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(user!.uid)
                                .get();
                        FirebaseFirestore.instance.collection('chats').add({
                          'text': _enteredMsg,
                          'createdAt': Timestamp.now(),
                          'userId': user!.uid,
                          'image_url': _userData['image_url'],
                          'username': _userData['username']
                        });
                        _messageController.clear();
                      },
                      child: Container(
                        height: 45,
                        width: 45,
                        child: Center(
                          child: Center(
                            child: Icon(
                              Icons.send,
                              color:
                                  themeData ? Colors.black54 : Colors.white54,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.green.withAlpha(225),
                                  blurRadius: 45,
                                  spreadRadius: 15,
                                  offset: Offset(0, 0))
                            ],
                            gradient: LinearGradient(
                                colors: [Colors.green, Colors.greenAccent],
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft),
                            shape: BoxShape.circle),
                      ),
                    )
            ],
          ),
        )
      ],
    ));
  }
}
