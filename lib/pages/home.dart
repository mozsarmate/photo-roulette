import "package:flutter/material.dart";

import "./lobby.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            title: const Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Hi, Blatin",
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 1,
            actions: [
              Container(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: const Image(
                  image: AssetImage("assets/images/avatar_example.png"),
                  width: 50,
                  height: 50,
                ),
              )
            ]),
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
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ElevatedButton(
                                  child: const Text("Join Game"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LobbyScreen(
                                                    gamePin: "123456",
                                                    key: null)));
                                  }),
                              /*Button(
                  text: "Join Game",
                  isPrimary: true,
                          action: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>const LobbyScreen(gamePin: "123456",key: null))
                    );
                  }
                ),*/
                              ElevatedButton(
                                  child: const Text("Create Game"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LobbyScreen(
                                                    gamePin: "123456",
                                                    key: null)));
                                  }),
                              /*Button(
                  text: "Create Game",
                  isPrimary: false,
                  action: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>const LobbyScreen(gamePin: "123456",key: null))
                    );
                  },
                )*/
                            ])))
              ],
            )));
  }
}
