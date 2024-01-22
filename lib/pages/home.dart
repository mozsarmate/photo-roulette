import "package:flutter/material.dart";
import "../components/button.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/main_background.jpg"),
            fit: BoxFit.cover
          )
        ),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Button(text: "Join Game", isPrimary: true),
                        Button(text: "Create Game", isPrimary: false)
                      ]
                  )
              )

          )
      )

    );
  }
}
