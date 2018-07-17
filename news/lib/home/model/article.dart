class Article {
  String id;
  String pubDate;
  bool havePic;
  String channelName;
  String title;
  String desc;
  String source;
  String channelId;
  String nid;
  String link;
  List<String> imageurls;

  Article.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        pubDate = json['pubDate'],
        havePic = json['havePic'],
        channelName = json['channelName'],
        title = json['title'],
        desc = json['desc'],
        source = json['source'],
        channelId = json['channelId'],
        nid = json['nid'],
        link = json['link'],
        imageurls = [] {
    for (var item in json['imageurls']) {
      imageurls.add(item['url']);
    }
  }
}

class ArticleList {
  List<Article> articles = [];

  ArticleList():articles=[];

  ArticleList.fromJson(Map<String, dynamic> json) {
    for (var item in json['showapi_res_body']['pagebean']['contentlist']) {
      articles.add(Article.fromJson(item));
    }
  }
}
