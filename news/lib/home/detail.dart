import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Detail extends StatefulWidget {
  final String url;
  Detail(this.url);
  @override
  DetailState createState() {
    // TODO: implement createState
    return new DetailState(this.url);
  }
}

class DetailState extends State<Detail> {
  final String url;
  final webView = new FlutterWebviewPlugin();
  String title = "Loading...";
  DetailState(this.url);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    webView.onUrlChanged.listen((url) async {
      var t = await webView.evalJavascript("window.document.title");
      setState(() {
        title = t.isEmpty ? "详情" : t;
      });
    });
  
    return new WebviewScaffold(
      url: url,
      appBar: new AppBar(
        title: new Text(title),
      ),
      withJavascript: true,
      withZoom: true,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
