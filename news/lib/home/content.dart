import 'package:flutter/material.dart';
import 'package:http/http.dart' as Http;
import './model/article.dart';
import 'dart:convert';
import 'package:news/config.dart';

class Content extends StatefulWidget {
  final String channelId;

  // OneColum({List<String> columnData}) : this.columnData = columnData;

  Content({String channelId}) : this.channelId = channelId;

  @override
  ContentState createState() => new ContentState(this.channelId);
}

class ContentState extends State<Content> {
  final String channelId;

  ContentState(this.channelId);

  bool _isloading = true;
  ArticleList _list = new ArticleList();

  _feachData() async {
    String baseUrl = Config.baseUrl;
    String apiId = Config.newsapiId;
    String appinfo = Config.appinfo;
    String url = "$baseUrl$apiId$appinfo" + "channelId=$channelId";
    await Http.get(url).then((Http.Response res) {
      // print(res.body);
      if (!mounted) {return ;}
      Map jsonMap = json.decode(res.body);
      // print(jsonMap);
      ArticleList list = ArticleList.fromJson(jsonMap);
      // list.articles.forEach((f) {
      //   print(f.title + ":" + f.pubDate + f.imageurls.length.toString());
      // });

      var newlist =
          list.articles.where((test) => test.havePic == true).toList();
      // print(list);

      setState(() {
        _isloading = false;
        _list.articles = newlist;
      });
      // print(list);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _feachData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _isloading
        ? new Center(
            child: new CircularProgressIndicator(),
          )
        : new SingleChildScrollView(
            child: new Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: new Column(
                children: _list.articles
                    .map((f) => new OneColum(articleData: f))
                    .toList(),
              ),
            ),
          );
  }
}

class OneColum extends StatelessWidget {
  final Article article;
  OneColum({Article articleData}) : article = articleData;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var stack = new Stack(
      children: <Widget>[
        new Image.network(article.imageurls.first),
        new Container(
          padding: const EdgeInsets.only(top: 210.0),
          child: new Container(
            decoration: new BoxDecoration(
              color: Colors.black45,
            ),
            alignment: Alignment.bottomLeft,
            width: 400.0,
            height: 50.0,
            child: new Center(
              child: new Text(
                article.title,
                textAlign: TextAlign.left,
                style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 1,
              ),
            ),
          ),
        )
      ],
    );

    return new Container(margin: const EdgeInsets.all(10.0), child: stack);
  }
  // final  List<String> columnData;

  // OneColum({List<String> columnData}) : this.columnData = columnData;

  // @override
  // // TODO: implement children
  // List<Widget> get children {
  //   return columnData.map((f) => new Text(f)).toList();
  // }
}
