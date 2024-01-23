
import 'package:flutter/material.dart';

class VotePanel extends StatefulWidget {
  const VotePanel({required this.names, super.key});
  final List<String> names;
  @override
  State<StatefulWidget> createState() => _VotePanelState(names);
}

class _VotePanelState extends State<VotePanel> {
  _VotePanelState(this.names);
  List<String> names;
  var vote = -1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      child: GridView.builder(
        reverse: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 8.0, // Spacing between columns
          mainAxisSpacing: 8.0, // Spacing between rows
          childAspectRatio: 2.4,
        ),
        itemCount: names.length, // 3 rows and 2 columns, so total 6 items
        itemBuilder: (context, index) {
          return ElevatedButton(
            onPressed: () {
              setState(() {
                vote = index;
              });
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(side: BorderSide(color: const Color(0x00000000)),borderRadius: BorderRadius.circular(20))),
              backgroundColor: MaterialStateProperty.all<Color>(vote == index
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary),
            ),
            child: Text(
                names[index], style: TextStyle(color: vote != index
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary, fontSize: 20)
            ),
          );
        },
      )
    );
  }
}