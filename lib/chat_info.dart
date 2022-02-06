// ignore_for_file: no_logic_in_create_state, avoid_print

import 'package:flutter/material.dart';
import 'chats.dart';
import 'chat_view.dart';

class ChatInfo extends StatefulWidget {
  int? id;
  String? name;
  List? chatUsers;
  bool? loaded;
  ChatInfo(this.id, this.name, this.chatUsers, this.loaded, {Key? key})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ChatInfoState(id!, name!, chatUsers!, loaded!);
  }
}

class ChatInfoState extends State<ChatInfo> {
  void update() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  ChatInfoState(this.id, this.name, this.chatUsers, this.loaded);
  int? id;
  String name = "";
  List chatUsers;
  bool loaded = false;
  @override
  Widget build(BuildContext context) {
    // if (!loaded) {
    //   update();
    // }
    TextButton back = TextButton(
        onPressed: () {
          print(chatUsers);
          Navigator.pop(context);
        },
        child: Container(
            padding: const EdgeInsets.only(top: 60),
            width: 100,
            child: Row(children: <Widget>[
              (Icon(Icons.arrow_back_rounded,
                  size: 25, color: Colors.blue[400])),
              (Text(
                ' Назад ',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.blue[400],
                ),
              ))
            ])));

    Row chaticon = Row(children: <Widget>[
      Container(
        height: 100,
        width: 100,
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(5),
                child: Center(
                    child: Text(
                  textForChatIcon(name),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 57,
                  ),
                )))
          ],
        ),
      )
    ]);

    Container upper = Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 15),
        color: Colors.white,
        height: 300,
        width: MediaQuery.of(context).size.width,
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[back, const Spacer()],
          ),
          const Spacer(),
          Row(children: <Widget>[const Spacer(), chaticon, const Spacer()]),
          const Spacer(),
          Text(name, style: const TextStyle(color: Colors.black, fontSize: 30)),
          const Spacer()
        ]));

    Column createUsers() {
      Column infopage = Column(
        children: <Widget>[
          upper,
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 35,
          )
        ],
      );
      for (int i = 0; i < chatUsers.length; i++) {
        infopage.children.add(Container(
            width: MediaQuery.of(context).size.width / 1.1,
            height: MediaQuery.of(context).size.height / 13,
            color: Colors.white,
            child: Row(children: <Widget>[
              Container(
                // padding: EdgeInsets.only(
                //     left: MediaQuery.of(context).size.width / 5),
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  children: <Widget>[
                    Center(
                        child: Text(
                      textForChatIcon(
                          chatUsers[i].name + " " + chatUsers[i].surname),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontFamily: "Helvetica"),
                    ))
                  ],
                ),
              ),
              Text(
                "  " + chatUsers[i].name + " " + chatUsers[i].surname,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ])));
      }
      return infopage;
    }

    return MaterialApp(
        home: Scaffold(
      body: ListView(children: <Widget>[createUsers()]),

      // Container(
      //     height: MediaQuery.of(context).size.height / 1.8,
      //     child: ListView(children: <Widget>[test])),

      backgroundColor: Colors.grey[300],
    ));
  }
}
