import 'package:flutter/material.dart';
// import 'package:news/config.dart';
import './model/channel.dart';
import 'package:http/http.dart' as Http;
import 'dart:convert';
import 'top.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeState();
  }
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  bool _isloading = true;
  ChannelList _list;
  _feachData() async {
    String appid = "69841";
    String secret = 'd8d735599e2c405987c2810061f15180';
    String baseUrl = 'http://route.showapi.com/';
    String apiId = '109-34';
    String url = "$baseUrl$apiId?showapi_appid=$appid&showapi_sign=$secret";
    await Http.get(url).then((Http.Response res) {
      print(res.statusCode);
      Map channelListJson = json.decode(res.body);
      // print(channelListJson);
      ChannelList list = ChannelList.fromJson(channelListJson);
      list.channels.forEach((f) {
        print(f.channelId + ":" + f.channelName);
      });
      _list = list;
      setState(() {
        _isloading = false;
      });
      // print(list);
    });
  }

  List<String> tabs = [
    "国内焦点",
    "国际焦点",
    "军事焦点",
    "财经焦点",
    "娱乐",
    "体育",
    "军事",
    "科技",
    "财经",
    "时尚"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _feachData();
    // featchData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _isloading
          ? new Material(
            child: new Center(
              child: new CircularProgressIndicator(),
            ),
          )
          : new DefaultTabController(
      length: _list.channels.length,
      child:  new Scaffold(
              appBar: new AppBar(
                title: new Text("新闻"),
                bottom: new TabBar(
                    isScrollable: true,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: _list.channels.map((f) => new Tab(text: f.channelName)).toList()),
              ),
              body: new TabBarView(
                children: _list.channels.map((f)=>new Text(f.channelName+f.channelId)).toList(),
              )),
    );
  }

  // featchData() {
  //   final url = "https://api.douban.com/v2/movie/in_theaters";
  //   final response = http.get(url);
  //   response.then((onValue){
  //     if (onValue.statusCode == 200){
  //       print(onValue.body);
  //       // final re = InTheaters.fromJson(onValue.body);
  //       // print(re.count);
  //     }
  //   });
  //   // if response.statusCode == 200 {
  //   //   print("ok");
  //   // }

  // }
}
