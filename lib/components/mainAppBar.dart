import 'package:flutter/material.dart';

AppBar mainAppBar = AppBar(
    title: const Align(
      alignment: Alignment.centerRight,
      child: Text(
        "Hi, Blatin", //TODO: insert name
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
    ]);
