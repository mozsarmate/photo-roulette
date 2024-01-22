// import "dart:html";

import "package:flutter/material.dart";
// import ="package:flutter_svg/flutter_svg.dart";

class Button extends StatelessWidget {
  final String text;
  final bool isPrimary;
  final double padding;
  final Function? action;

  const Button(
      {super.key,
      required this.text,
      required this.isPrimary,
      this.padding = 10.0,
      this.action,
      });

  @override
  Widget build(BuildContext context) {
    Color bgColor = isPrimary
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;
    return GestureDetector(
      onTap: action!(),
      child: Container(
          margin: EdgeInsets.all(padding),
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(child: Text(text)
          )
      )
    );
  }
}
