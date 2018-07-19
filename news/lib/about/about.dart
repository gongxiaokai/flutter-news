import 'package:flutter/material.dart';
import 'package:news/config.dart';
class About extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new AboutState();
}

class AboutState extends State<About> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
        theme: Config.themeData,
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text("关于"),
          ),
          body: new Center(
            child: new Text("about data"),
          ),
        ));
  }
}
