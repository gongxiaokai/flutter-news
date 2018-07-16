import 'package:flutter/material.dart';


class Top extends StatefulWidget {
  @override
    TopState createState() => new TopState();
}


class TopState extends State<Top> {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new SingleChildScrollView(
        child: new Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: new Column(
            children: <Widget>[
              new Text("data"),
              new Text("data2"),
              new Text("data3"),
            ],
          ),
        ),
      );
    }
}