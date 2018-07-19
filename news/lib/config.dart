import 'package:flutter/material.dart';
import 'home/model/weType.dart';


// var configSingletn = new Config();

// Config get singleton => Config.instance;

class Config {
  static ThemeData themeData = new ThemeData.light();
  static Color mainColor = Colors.blue;
  static String baseUrl = "http://route.showapi.com/";
  static String appid = "69841";
  static String secret = 'd8d735599e2c405987c2810061f15180';
  static String appinfo = "?showapi_appid=69841&showapi_sign=d8d735599e2c405987c2810061f15180&";
  static String weTypeId = '582-1';
  static String weDetail = '582-2';
  
 static Config _instance;

  factory Config() => _instance ??= new Config._();
  
  List<WeType>  allTypes = [];
  List<WeType>  selectedTypes = [];

  static Config shared = new Config();

  Config._() {
    
  }
  // static final Config instance = Config._private();
  // Config._private();
  // factory Config() => instance;
  // factory Config(){
  //   return _config;
  // }

}

