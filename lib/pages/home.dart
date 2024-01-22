import "package:flutter/material.dart";
import "package:photo_roulette/themes/themes.dart";
import "./lobby.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Color primary=Theme.of(context).colorScheme.primary;
    Color secondary=Theme.of(context).colorScheme.secondary;
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
        ]
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/main_background.jpg"),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 150, left: 20),
              child: Text("Photo\nRoulette",
                style: TextStyle(
                  fontSize: 60, color: Colors.white, height: 1
                )
              )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width:300,height:65,
                      decoration: ShapeDecoration(shape: RoundedRectangleBorder(side: const BorderSide(color: colorPrimary),borderRadius: BorderRadius.circular(20)),color:Colors.white),
                      child: TextField(
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),

                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.resolveWith((states) => const Size(300,50)),
                        shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(side: const BorderSide(color: Color(0x00000000)),borderRadius: BorderRadius.circular(20))),
                        backgroundColor: MaterialStateProperty.resolveWith((states) => colorSecondary),
                      ),
                      child: const Text("Join Game",style: TextStyle(color:colorPrimary),),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LobbyScreen(gamePin: "123456", key: null))
                        );
                      }
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.resolveWith((states) => const Size(300,50)),
                        shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(side: const BorderSide(color: Color(0x00000000)),borderRadius: BorderRadius.circular(20))),
                        backgroundColor: MaterialStateProperty.resolveWith((states) => colorPrimary),
                      ),
                      child: const Text("Create Game",style: TextStyle(color:colorSecondary),),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=>const LobbyScreen(gamePin: "123456",key: null))
                        );
                      }
                    ),
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }
}
