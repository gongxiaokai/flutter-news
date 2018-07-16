import 'package:flutter/material.dart';
import 'package:news/config.dart';
import 'package:news/navigationIcon.dart';
import 'top.dart';
class Home extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return new HomeState();
    }
}

class HomeState extends State<Home> with TickerProviderStateMixin {

  List<String> tabs = ["头条","社会","国内","国际","娱乐",
                      "体育","军事","科技","财经","时尚"];

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      // featchData();
    }
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new DefaultTabController(
        length: tabs.length,
        child: new Scaffold(
        appBar: new AppBar(
          title: new Text("新闻"),
          bottom: new TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            tabs: tabs.map((f)=>new Tab(text:f)).toList()
          ),
        ),
        body: new TabBarView(
          children: <Widget>[
            new Top(),
            new Text("data2"),
            new Text("data3"),
            new Text("data4"),
            new Text("data5"),
            new Text("data6"),
            new Text("data7"),
            new Text("data8"),
            new Text("data9"),
            new Text("data10"),
          ],
        )
      ),
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
