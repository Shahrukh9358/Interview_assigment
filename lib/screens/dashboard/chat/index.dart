import 'package:assignment_project/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textEditingController = TextEditingController();
  List messages = [];
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  fetchMessages() async {
    db.collection(AppConstants.messageCollection).snapshots().listen((val) {
      setState(() {
        messages = val.docs.map((d) => d.data()).toList();
        messages.sort((a, b) => b['time'].compareTo(a['time']));
      });
    });
  }

  @override
  void initState() {
    super.initState();

    fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.withOpacity(0.06),
      child: Column(
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                reverse: true,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isCurrentUser = message["uid"] == auth.currentUser!.uid;
                  final timestamp = DateTime.fromMillisecondsSinceEpoch(message["time"]);
                  final formattedTime = DateFormat('hh:mm a').format(timestamp);

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: isCurrentUser ? Colors.blueAccent : Colors.grey[300],
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                            children: [
                              Text(
                                message["message"],
                                style: TextStyle(
                                  color: isCurrentUser ? Colors.white : Colors.black,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                formattedTime,
                                style: TextStyle(
                                  color: isCurrentUser ? Colors.white70 : Colors.black54,
                                  fontSize: 10.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
          ),
          SizedBox(height: 12,),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: "Type your message...",
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    if (_textEditingController.text.trim().isNotEmpty) {
                      db.collection(AppConstants.messageCollection).add({
                        "message": _textEditingController.text,
                        "uid": auth.currentUser!.uid,
                        "time": DateTime.now().microsecondsSinceEpoch,
                        "message_type": "text"
                      });

                      setState(() {
                        _textEditingController.text = "";
                      });
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
