import 'package:flutter/material.dart';
import 'package:http/http.dart' as Http;
import './model/article.dart';
import 'dart:convert';
import 'package:news/config.dart';
import 'package:transparent_image/transparent_image.dart';

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
    final String baseUrl = Config.baseUrl;
    final String apiId = Config.newsapiId;
    final String appinfo = Config.appinfo;
    final String url = "$baseUrl$apiId$appinfo" + "channelId=$channelId";
    final response = await Http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.statusCode);
      Map jsonMap = json.decode(response.body);
      // print(jsonMap);
      ArticleList list = ArticleList.fromJson(jsonMap);
      // list.articles.forEach((f) {
      //   print(f.title + ":" + f.pubDate + f.imageurls.length.toString());
      // });

      var newlist =
          list.articles.where((test) => test.havePic == true).toList();
      // print(list);
      _list.articles = newlist;

      if (!mounted) {
        return;
      }
      print("aaa");
      setState(() {
        _isloading = false;
      });
    }
    // await Http.get(url).then((Http.Response res) {
    //   // print(res.body);

    //   // print(list);
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _feachData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
    print(article.imageurls.first.contains('baidu'));
    var stack = new Stack(
      children: <Widget>[
        !article.imageurls.first.contains('baidu')
            ? new Image.network(article.imageurls.first,width: 400.0,height: 200.0,)
            : new Center(child: new Icon(Icons.error)) ,
        new Container(
          padding: const EdgeInsets.only(top: 150.0),
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

    return new Container(
      height: 200.0,
      width: 400.0,
      margin: const EdgeInsets.all(10.0), 
      child: stack
      );
  }
  // final  List<String> columnData;

  // OneColum({List<String> columnData}) : this.columnData = columnData;

  // @override
  // // TODO: implement children
  // List<Widget> get children {
  //   return columnData.map((f) => new Text(f)).toList();
  // }
}
