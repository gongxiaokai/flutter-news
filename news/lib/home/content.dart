import 'package:flutter/material.dart';
import 'package:news/home/model/article.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'detail.dart';
import 'package:news/api/api.dart';
import 'dart:async';

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
  List<Article> _list = [];
  ScrollController _contraller = new ScrollController();
  int currentPage = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contraller.addListener(() {
      var maxScroll = _contraller.position.maxScrollExtent;
      var pixels = _contraller.position.pixels;
      if (maxScroll == pixels) {
        currentPage++;
        _featchData();
      }
    });

    _featchData();
  }

  _featchData() {
    API.featchTypeDetailList(currentPage, typeId, (List<Article> callback) {
      setState(() {
        _isloading = false;
        _list.addAll(callback);
      });
    }, errorback: (e) {
      print("error:$e");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _contraller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _isloading
        ? new Center(
            child: new CircularProgressIndicator(),
          )
        : new RefreshIndicator(
            onRefresh: _refresh,
            child: new ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, index) {
                return new OneColum(articleData: _list[index]);
              },
            controller: _contraller,
            )
          );
  }

  Future<Null> _refresh() async {
    currentPage = 1;
    _list = [];
    _featchData();
    return null;
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
