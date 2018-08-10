import 'package:flutter/material.dart';
import 'package:news/config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

class About extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new AboutState();
}

class AboutState extends State<About> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final TapGestureRecognizer recognizer = new TapGestureRecognizer();
    recognizer.onTap = () async {
      print("object");
      const url = 'https://flutter.io';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
      // Scaffold.of(context).showSnackBar(new SnackBar(
      //   content: new Text("data"),
      // ));
    };
    return new MaterialApp(
      theme: Config.themeData,
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text("关于"),
          ),
          body: new Column(
            children: <Widget>[
              new Container(
                height: 50.0,
              ),
              new Center(
                child: Image.asset(
                  "imgs/logo.png",
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.contain,
                ),
              ),
              new Container(
                height: 20.0,
              ),
              new Center(
                child: new Text(Config.version),
              ),
              new Container(
                height: 20.0,
              ),
              new RaisedButton(
                  color: Colors.white,
                  onPressed: () {
                    _launchURL();
                  },
                  child: new Container(
                    child: new Row(
                      children: <Widget>[
                        new Image.asset("imgs/github.png",width: 20.0,height: 20.0),
                        new Container(width: 20.0),
                        new Text("Source Code")
                      ],
                    ),
                  )),
              new Container(
                height: 20.0,
              ),
              new RichText(
                text: new TextSpan(
                  text: 'Powered by ',
                  style: TextStyle(color: Colors.black, fontSize: 10.0),
                  children: <TextSpan>[
                    new TextSpan(
                        text: 'Flutter',
                        style: new TextStyle(color: Config.mainColor),
                        recognizer: recognizer),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  _launchURL() async {
    const url = 'https://github.com/gongxiaokai/flutter-news';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
