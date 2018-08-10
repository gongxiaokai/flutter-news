import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:news/home/model/weType.dart';

class Shared {
  //保存分类
  static Future saveSelectedType(List<String> list) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    await pre.setStringList("selectedTypeIds",list);
    print(list);
    return;
  }

  //获取已选择的分类
  static Future<List<String>> getSelectedType() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    try {
      List<String> typeIds = pre.getStringList("selectedTypeIds");
      print("typeids = $typeIds");
      return typeIds;
    } catch (e) {
      return null;
    }
  }
}


class UserSinglen {
   List<WeType> allTypes = [];
  static final UserSinglen _singleton = new UserSinglen._internal();
  factory UserSinglen() {
    return _singleton;
  }
  UserSinglen._internal();
}
