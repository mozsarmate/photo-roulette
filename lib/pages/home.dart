import "package:flutter/material.dart";
import "../components/button.dart";
import "./lobby.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/main_background.jpg"),
            fit: BoxFit.cover
          )
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: const Text("Join Game"),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>const LobbyScreen(gamePin: "123456",key: null))
                    );
                  }
                ),
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
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=>const LobbyScreen(gamePin: "123456",key: null))
                      );
                    }
                ),
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
              ]
            )
          )
        )
      )
    );
  }
}
