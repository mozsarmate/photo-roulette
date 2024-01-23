// import "dart:html";

import "package:flutter/material.dart";
// import ="package:flutter_svg/flutter_svg.dart";

class Button extends StatelessWidget {
  final String text;
  final bool isPrimary;
  final double margin;
  final void Function()? action;

  const Button({
    super.key,
    required this.text,
    required this.isPrimary,
    this.margin = 5,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = isPrimary
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;

    Color fgColor = isPrimary
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).colorScheme.primary;

    return Container(
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
            onPressed: action,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(bgColor),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.focused) ||
                        states.contains(MaterialState.pressed)) {
                      return fgColor.withOpacity(0.12);
                    }
                    return null; // Defer to the widget's default.
                  },
                ),
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(const Size(180, 50))),
            child: Text(text,
                style: const TextStyle(color: Colors.white, fontSize: 17))));
  }
}
