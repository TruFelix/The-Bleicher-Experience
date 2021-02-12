import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(body: home()),
    );
  }
}

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Text("Text"),
        ),
        ColoredThing(color: Colors.amber),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColoredThing(color: Colors.lightGreen),
            ColoredThing(color: Colors.red),
          ],
        )
      ],
    );
  }
}

class ColoredThing extends StatelessWidget {
  final Color color;

  ColoredThing({@required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: this.color,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
