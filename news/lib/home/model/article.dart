class Article {
  final String date;
  final String url;
  final String id;
  final String typeName;
  final String contentImg;
  final String title;


  Article.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = json['date'],
        url = json['url'],
        typeName = json['chtypeNameannelName'],
        contentImg = json['contentImg'],
        title = json['title'];
}

class ArticleList {
  List<Article> articles;

  ArticleList():articles=[];

  ArticleList.fromJson(Map<String, dynamic> json) {
    articles = [];
    for (var item in json['showapi_res_body']['pagebean']['contentlist']) {
      articles.add(Article.fromJson(item));
    }
  }
}
