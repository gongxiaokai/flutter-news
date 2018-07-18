import 'package:flutter/material.dart';
import 'package:http/http.dart' as Http;
import './model/article.dart';
import 'dart:convert';
import 'package:news/config.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'detail.dart';
class Content extends StatefulWidget {
  final String channelId;

  // OneColum({List<String> columnData}) : this.columnData = columnData;

  Content({String channelId}) : this.channelId = channelId;

  @override
  ContentState createState() => new ContentState(this.channelId);
}

class ContentState extends State<Content> {
  final String typeId;

  ContentState(this.typeId);

  bool _isloading = true;
  ArticleList _list = new ArticleList();

  _feachData() async {
    final String baseUrl = Config.baseUrl;
    final String apiId = Config.weDetail;
    final String appinfo = Config.appinfo;
    final String url = "$baseUrl$apiId$appinfo" + "typeId=$typeId";
    await Http.get(url).then((Http.Response response) {
      if (response.statusCode == 200) {
        print(response.statusCode);
        Map jsonMap = json.decode(response.body);
        // print(jsonMap);
        ArticleList list = ArticleList.fromJson(jsonMap);
        if (!mounted) {
          return;
        }
        print("aaa");
        setState(() {
          _list = list;
          _isloading = false;
        });
      }
    });
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
    var stack = new Stack(
      children: <Widget>[
        new CachedNetworkImage(
          imageUrl: article.contentImg,
          errorWidget: new Center(child: new Icon(Icons.error)),
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        new GestureDetector(
            child: new Container(
              decoration: new BoxDecoration(
                color: Colors.black45,
              ),
              child: _ArticleTitleWidget(
                title: article.title,
              ),
            ),
            onTap: () {
              Navigator.push(context,
              new MaterialPageRoute(
                builder: (context)=> new Detail(article.url)
              ));
              print("ed");
            }),
      ],
    );

    return new Container(
        height: 200.0,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 10.0),
        child: stack);
  }
}


class _ArticleTitleWidget extends StatelessWidget {
  final String title;
  _ArticleTitleWidget({String title}) : title = title;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new Text(
        title,
        textAlign: TextAlign.center,
        style: new TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
