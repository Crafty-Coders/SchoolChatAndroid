// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names, must_be_immutable, prefer_const_literals_to_create_immutables, no_logic_in_create_state
import 'package:flutter/material.dart';
import 'socket_io_manager.dart';
import 'models.dart';
import 'dart:io';
import 'msg.dart';
import 'chats.dart';

class ChatView extends StatefulWidget {
  @override
  int? id;
  String name = "";
  ChatView(this.id, this.name);
  State<StatefulWidget> createState() {
    print("ID in chatview");
    print(id);
    return ChatViewState(id, name);
  }
}

var MessagesSize = ValueNotifier<int>(0);

List messages = [];
Column msgRows = Column();
bool curruser = true;

class ChatViewState extends State<ChatView> {
  @override
  int? id;
  String name = "";
  double x = 0.0;
  double y = 0.0;
  Color color = Color(0x0fffffff);
  ChatViewState(this.id, this.name);
  // ChatViewState(this.id);
  int updCount = 0;
  var ShouldUpdate = true;
  void update() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    int lastSize = 0;
    void get_message(mass) {
      messages.clear();
      var data = mass['data'];
      for (int o = 0; o < data.length; o++) {
        // if (data[o]["chat_id"] == 2) {
        print("ID:");
        print(id);
        messages.add(Message(
            int.parse(data[o]["id"]),
            int.parse(data[o]["chat_id"]),
            int.parse(data[o]["user_id"]),
            data[o]["text"],
            data[o]["attachments"],
            data[o]["deleted_all"],
            data[o]["deleted_user"],
            data[o]["edited"],
            data[o]["service"],
            data[o]["updatedAt"]));
        update();
        // }
        lastSize = messages.length;
        MessagesSize = ValueNotifier<int>(messages.length);
      } // print(data[o]);
      Column createMsgs() {
        Column columnOfMessages = Column(children: <Widget>[]);
        for (int i = 0; i < messages.length; i++) {
          print("vnizu MSG");
          print(messages[i].text);

          if (messages[i].user_id == currentuser.id) {
            x = 1.0;
            y = -1.0;
            curruser = true;
            color = Color(0x0f4d76ff);
          } else {
            x = -1.0;
            y = -1.0;
            curruser = false;
            color = Color(0x0f656b80);
          }

          Align msg = Align(
              alignment: Alignment(x, y),
              child: Container(
                  color: color,
                  child:
                      createMsgView(messages[i].text, messages[i].updatedAt)));
          columnOfMessages.children.add(msg);
        }
        return columnOfMessages;
      }

      msgRows = createMsgs();
      update();
      // String tt = messages[0].updatedAt;
      // print(tt);
    }

    print("vnizu messages");
    print(messages);
    print(MessagesSize);
    recieve_chat_msgs(get_message);
    if (ShouldUpdate) {
      requestChatMsgs(2, id!);
      ShouldUpdate = false;
    }

    Row chaticon = Row(children: <Widget>[
      Container(
        padding: EdgeInsets.only(),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: <Widget>[
            Container(
                // padding: EdgeInsets.only(top: 17, left: 4),
                padding: EdgeInsets.all(5),
                child: Center(
                    child: Text(
                  textForChatIcon(name),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                )))
          ],
        ),
      ),
      Text(name, style: TextStyle(fontSize: 18, color: Colors.black))
    ]);
    TextButton back = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Row(children: <Widget>[
          (Icon(Icons.arrow_back_rounded, size: 25, color: Colors.blue[400])),
          (Text(
            '  Чаты  ',
            style: TextStyle(
              fontSize: 17,
              color: Colors.blue[400],
            ),
          ))
        ]));
    TextButton sendmsg = TextButton(
      onPressed: () {},
      child: Icon(
        Icons.send,
        color: Colors.blue[400],
        size: 30,
      ),
    );
    Container entermsg = Container(
        width: 290,
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: Colors.black,
            ),
            hintText: 'Сообщение',
            fillColor: Colors.grey,
            filled: true,
          ),
        ));
    Align bottom = Align(
        alignment: Alignment.bottomCenter,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[entermsg, sendmsg]));
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.white,
                title: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[back, chaticon],
                )),
            bottomSheet: Container(
              height: kToolbarHeight,
              child: AppBar(
                title: bottom,
                backgroundColor: Colors.white,
              ),
            ),
            body: ListView(children: <Widget>[
              Container(
                  color: Colors.white,
                  alignment: FractionalOffset(0.5, 0.2),
                  child: Column(children: <Widget>[
                    msgRows
                  ] //[msgRows],      //child: test,
                      ))
            ])));
  }
}
