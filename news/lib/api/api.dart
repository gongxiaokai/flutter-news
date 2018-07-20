import 'package:http/http.dart' as Http;
import 'package:news/config.dart';
import 'package:news/home/model/weType.dart';
import 'package:news/home/model/article.dart';
import 'dart:convert';
import 'package:news/shared.dart';

class API {
  //获取分类
  static void featchTypeListData(Function callback,
      {List<WeType> typeList, Function errorback}) async {
    String appid = Config.appid;
    String secret = Config.secret;
    String baseUrl = Config.baseUrl;
    String apiId = Config.weTypeId;
    String url = "$baseUrl$apiId?showapi_appid=$appid&showapi_sign=$secret";
    try {
      await Http.get(url).then((Http.Response res) {
        if (res.statusCode == 200) {
          Map jsonMap = json.decode(res.body);
          // WeTypeList list = WeTypeList.fromJson(typeListJson);
          List jsonlist = jsonMap['showapi_res_body']['typeList'];
          List<WeType> list = jsonlist.map((f) => WeType.fromJson(f)).toList();
          Shared.saveSelectedType(list);
          callback(list);
        }else {
          errorback(res.body);
        }
      });
    } catch (e) {
      errorback(e);
    }
  }

  //获取分类数据详情
  static void featchTypeDetailList(String typeId, Function callback,{List<Article> artileList, Function errorback}) async {
    final String baseUrl = Config.baseUrl;
    final String apiId = Config.weDetail;
    final String appinfo = Config.appinfo;
    final String url = "$baseUrl$apiId$appinfo" + "typeId=$typeId";
    try {
      await Http.get(url).then((Http.Response response) {
      if (response.statusCode == 200) {
        print(response.statusCode);
        Map jsonMap = json.decode(response.body);
        List jsonlist = jsonMap['showapi_res_body']['pagebean']['contentlist'];
        List<Article> list = jsonlist.map((f) => Article.fromJson(f)).toList();
        // ArticleList list = ArticleList.fromJson(jsonMap);
        callback(list);
      }else{
        errorback(response.body);
      }
    });
    } catch (e) {
      errorback(e);
    }
    
  }
}
