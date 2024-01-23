import "package:flutter/material.dart";
import "package:photo_roulette/components/mainAppBar.dart";
import "package:photo_roulette/themes/themes.dart";

import "../components/button.dart";
import "./lobby.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final pinController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  FocusNode _focusNode1 = FocusNode();
  int focused = -1;

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      print("f1");
      if (_focusNode1.hasFocus) {
        setState(() {
          focused = 1;
        });
      }else{
        setState(() {
          focused = -1;
        });
      }
    });
    _focusNode.addListener(() {
      print("f2");
      if (_focusNode.hasFocus) {
        setState(() {
          focused = 0;
        });
      }else{
        setState(() {
          focused = -1;
        });
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    pinController.dispose();
    super.dispose();
  }

  //final buttonArea =
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: mainAppBar,
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/main_background.jpg"),
                    fit: BoxFit.cover)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.only(top: 150, left: 20),
                      child: Text("Photo\nRoulette",
                          style: TextStyle(
                              fontSize: 60, color: Colors.white, height: 1))),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Button(
                                  isPrimary: true,
                                  text: "Create Game",
                                  width: 300,
                                  action: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LobbyScreen(
                                                gamePin: "123456",
                                                name: nameController.text,
                                                key: null)));
                                  },
                                ),
                                Container(
                                  width: 300,
                                  height: 50,
                                  decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(color: colorPrimary),
                                          borderRadius: BorderRadius.circular(20)),
                                      color: Colors.white),
                                  child: TextField(
                                    focusNode: _focusNode1,
                                    controller: pinController,
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center,
                                    textAlignVertical: TextAlignVertical.top,
                                    decoration: InputDecoration(
                                      border:
                                      OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                                      hintText: 'Game Pin',
                                    ),
                                  ),
                                ),
                                Button(
                                    isPrimary: false,
                                    text: "Join Game",
                                    width: 300,
                                    action: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => LobbyScreen(
                                                  gamePin: pinController.text,
                                                  name: nameController.text,
                                                  key: null)));
                                    }),
                              ])))
                ])));
  }
}
