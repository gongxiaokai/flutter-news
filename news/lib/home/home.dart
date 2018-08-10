import 'package:flutter/material.dart';
import 'package:news/home/model/weType.dart';
import 'content.dart';
import 'package:news/api/api.dart';
import 'package:news/shared.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  bool _isloading = true;
  List<WeType> _list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    API.featchTypeListData((List<WeType> callback) {
      Shared.getSelectedType().then((onValue) {
        print(onValue);
        if (onValue != null) {
          print("lentch = ");
          print(onValue.length);
          setState(() {
            _isloading = false;
            _list = callback.where((t) => onValue.contains(t.id)).toList();
          });
        }
      });
    }, errorback: (error) {
      print("error:$error");
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _isloading
        ? new Scaffold(
            appBar: new AppBar(
              title: new Text("loading..."),
            ),
            body: new Center(
              child: new CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            ),
          )
        : new DefaultTabController(
            length: _list.length,
            child: new Scaffold(
                appBar: new AppBar(
                  title: new Text("新闻"),
                  bottom: new TabBar(
                      isScrollable: true,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: _list.map((f) => new Tab(text: f.name)).toList()),
                ),
                body: new TabBarView(
                  children:
                      _list.map((f) => new Content(channelId: f.id)).toList(),
                )),
          );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
