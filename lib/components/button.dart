import "package:flutter/material.dart";

class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(100),
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFF1A36B9),
          borderRadius: BorderRadius.circular(20),
        ));
  }
}
