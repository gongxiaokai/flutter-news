import 'package:flutter/material.dart';
import 'config.dart';
import 'navigationIcon.dart';
import 'index.dart';

void main() => runApp(new DoubanMovie());


class DoubanMovie extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      return new MaterialApp(
        theme: Config.themeData,
        title: "News",
        home: new Index(),
      );
    }
}