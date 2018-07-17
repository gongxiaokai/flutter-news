// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as Http;
// import './model/channel.dart';
// import 'dart:convert';
// import 'package:news/config.dart';
// class Top extends StatefulWidget {
//   @override
//   TopState createState() => new TopState();
// }

// class TopState extends State<Top> {
//   bool _isloading = true;

//   ChannelList _list;
//   _feachData() async {
//     String appid = Config.appid;
//     String secret = Config.secret;
//     String baseUrl = Config.baseUrl;
//     String apiId = Config.apiId;
//     String url = "$baseUrl$apiId?showapi_appid=$appid&showapi_sign=$secret";
//     await Http.get(url).then((Http.Response res) {
//       // print(res.body);
//       Map channelListJson = json.decode(res.body);
//       // print(channelListJson);
//       ChannelList list = ChannelList.fromJson(channelListJson);
//       list.channels.forEach((f) {
//         print(f.channelId + ":" + f.channelName);
//       });
//       _list = list;
//       setState(() {
//         _isloading = false;
//       });
//       // print(list);
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //  _feachData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return _isloading
//         ? new Center(
//             child: new CircularProgressIndicator(),
//           )
//         : new SingleChildScrollView(
//             child: new Container(
//               margin: const EdgeInsets.only(top: 10.0),
//               child: new Column(
//                 children: <Widget>[new OneColum(),new OneColum()],
//               ),
//             ),
//           );
//   }
// }

// class OneColum extends StatelessWidget {

//   @override
//     Widget build(BuildContext context) {
//       // TODO: implement build
//       return new Text("data2");
//     }
//   // final  List<String> columnData;

//   // OneColum({List<String> columnData}) : this.columnData = columnData;

//   // @override
//   // // TODO: implement children
//   // List<Widget> get children {
//   //   return columnData.map((f) => new Text(f)).toList();
//   // }
// }
