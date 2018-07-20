import 'package:flutter/material.dart';
import 'package:news/home/model/weType.dart';
import 'content.dart';
import 'package:news/api/api.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeState();
  }
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  bool _isloading = true;
  List<WeType> _list;
  // var config = configSingletn;
  // _feachData() async {
  //   String appid = Config.appid;
  //   String secret = Config.secret;
  //   String baseUrl = Config.baseUrl;
  //   String apiId = Config.weTypeId;
  //   String url = "$baseUrl$apiId?showapi_appid=$appid&showapi_sign=$secret";
  //   await Http.get(url).then((Http.Response res) {
  //     Map typeListJson = json.decode(res.body);
  //     WeTypeList list = WeTypeList.fromJson(typeListJson);
  //     //获取缓存数据
  //     Shared.saveSelectedType(list.types).then((onValue) {
  //       if (onValue != null) {
  //         print(onValue.length.toString() + "0009999");
  //         setState(() {
  //           _isloading = false;
  //           _list = onValue;
  //         });
  //       }
  //     });
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _feachData();

    API.featchTypeListData((List<WeType> callback) {
      setState(() {
        _isloading = false;
        _list = callback;
      });
    }, errorback: (error) {
      print("error:$error");
    });
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
