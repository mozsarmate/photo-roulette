import 'package:flutter/material.dart';

class LobbyScreen extends StatelessWidget{
  const LobbyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/main_background.jpg"),
            fit: BoxFit.cover
          )
        ),

      )
    );
  }
  
}

