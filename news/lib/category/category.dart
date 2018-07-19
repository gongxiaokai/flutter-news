import 'package:flutter/material.dart';
import 'package:news/config.dart';
import 'package:news/home/model/weType.dart';
class Category extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new CategoryState();
}

class CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

  // var config = configSingletn;
  // var list = config.allTypes;
  // // list = list.where((test) => int.parse(test.id) < 5).toList();
  //   print("aaa");
  //   for (var item in list) {
  //     WeType a = item;
  //   print(item);
  //   }
  // config.allTypes = list;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("分类"),
      ),
      body: new Center(child: new Text("category data")),
    );
  }
}
