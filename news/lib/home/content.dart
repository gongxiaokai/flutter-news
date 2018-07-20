import 'package:flutter/material.dart';
import 'package:news/home/model/article.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'detail.dart';
import 'package:news/api/api.dart';

class Content extends StatefulWidget {
  final String channelId;


  Content({String channelId}) : this.channelId = channelId;

  @override
  ContentState createState() => new ContentState(this.channelId);
}

class ContentState extends State<Content> {
  final String typeId;

  ContentState(this.typeId);

  bool _isloading = true;
  List<Article> _list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    API.featchTypeDetailList(typeId, (List<Article> callback) {
      setState(() {
        _isloading = false;
        _list = callback;
      });
    }, errorback: (e) {
      print("error:$e");
    });
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
                children: _list
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new Detail(article.url)));
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
