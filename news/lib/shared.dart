import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:news/home/model/weType.dart';

class Shared {
  //保存分类
  static saveSelectedType(List<String> list) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    await pre.setStringList("selectedTypeIds",list);
  }

  //获取已选择的分类
  static Future<List<String>> getSelectedType() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    try {
      List<String> typeIds = pre.getStringList("selectedTypeIds");
      return typeIds;
    } catch (e) {
      return null;
    }
  }

//   //保存所有分类
//   static Future<List<WeType>> saveAllType(List<WeType> list) async {
//     SharedPreferences pre = await SharedPreferences.getInstance();
//     await pre.setStringList(
//         "allTypeNames",
//         list.map((WeType f) {
//           return f.name;
//         }).toList());
//     await pre.setStringList(
//         "allTypeIds",
//         list.map((WeType f) {
//           return f.id;
//         }).toList());
//     return getAllType();
//   }

//   //获取所有分类
//   static Future<List<WeType>> getAllType() async {
//     SharedPreferences pre = await SharedPreferences.getInstance();
//     List<String> typeNames = pre.getStringList("allTypeNames");
//     List<String> typeIds = pre.getStringList("allTypeIds");
//     List<WeType> allType = [];
//     for (var i = 0; i < typeIds.length; i++) {
//       WeType type = new WeType(typeIds[i], typeNames[i], true);
//       allType.add(type);
//     }
//     return allType;
//   }
}


class UserSinglen {
   List<WeType> allTypes = [];
  static final UserSinglen _singleton = new UserSinglen._internal();
  factory UserSinglen() {
    return _singleton;
  }
  UserSinglen._internal();
}
