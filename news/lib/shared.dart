import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:news/home/model/weType.dart';

class Shared {
  //保存分类
  static Future<List<WeType>> saveSelectedType(List<WeType> list) async{
    SharedPreferences pre =  await SharedPreferences.getInstance();
    await pre.setStringList("typeNames", list.map((WeType f) { return f.name;}).toList());
    await pre.setStringList("typeIds", list.map((WeType f) {return f.id;}).toList());
    return getSelectedType();
  }

  //获取已选择的分类
  static Future<List<WeType>> getSelectedType() async {
    SharedPreferences pre =  await SharedPreferences.getInstance();
    List<String> typeNames = pre.getStringList("typeNames");
    List<String> typeIds = pre.getStringList("typeIds");
    List<WeType> selectedType = [];
    for (var i = 0; i < typeIds.length; i++) {
      WeType type = new WeType(typeIds[i], typeNames[i]);
      selectedType.add(type);
    }
    return selectedType;
  }
}