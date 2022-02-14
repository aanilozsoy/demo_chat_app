import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demo_chat_app/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';

// import 'package:firebase_auth/firebase_auth.dart';
final _fireStore = FirebaseFirestore.instance;
late User loggedUser;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  // void messagesStream() async {
  //   await for (var snapshot in _fireStore.collection('messages').snapshots()) {
  //     for (var msg in snapshot.docs) {
  //       print(msg.data());
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              children: <Widget>[
                const Text(
                  'Log out',
                  style: TextStyle(fontSize: 15.0),
                ),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.chevronCircleRight),
                  onPressed: () {
                    _auth.signOut();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
        title: const Text('Chat'),
        backgroundColor: const Color(0xFF4D4D4D),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamOfMessages(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      _fireStore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedUser.email,
                      });
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class StreamOfMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data?.docs.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var msg in messages!) {
            final messageText = msg.get('text');
            final messageSender = msg.get('sender');
            final currentUser = loggedUser.email;

            final messageBubble = MessageBubble(
              msgText: messageText,
              sender: messageSender,
              isMe: currentUser == messageSender,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              children: messageBubbles,
            ),
          );
        }
        return const Text("No Data");
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MessageBubble(
      {required this.sender, required this.msgText, required this.isMe});

  final String sender;
  final String msgText;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(sender),
          Material(
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0),
                  )
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
            elevation: 3.0,
            color: isMe
                ? const Color.fromARGB(179, 0, 34, 13)
                : const Color.fromARGB(255, 121, 107, 62),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Text(
                msgText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
