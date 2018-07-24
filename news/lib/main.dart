import 'package:flutter/material.dart';
import 'config.dart';
import 'index.dart';

void main() => runApp(new FlutterNews());


class FlutterNews extends StatelessWidget {

  @override
    Widget build(BuildContext context) {
      return new MaterialApp(
        theme: Config.themeData,
        title: "News",
        home: new Index(key: new Key("index"))
      );
    }
}