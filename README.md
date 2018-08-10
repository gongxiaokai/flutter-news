Flutter 简易新闻项目

# 目标
使用flutter快速开发 Android 和 iOS 的简易的新闻客户端
API使用的是 [showapi(易源数据)](https://www.showapi.com/) 加载热门微信文章

# 效果对比

| Android     | iOS     |
| :-------------: | :-------------: |
| ![](https://imgurl.xyz/images/2018/08/10/0b4986c89eab.md.png)       | ![](https://imgurl.xyz/images/2018/08/10/e2a497fee872.md.png)      |
|![](https://imgurl.xyz/images/2018/08/10/2ad53d8755cf.md.png)|![](https://imgurl.xyz/images/2018/08/10/29a4d8c4e377.md.png)|
|![](https://imgurl.xyz/images/2018/08/10/5ada845d8ab4.md.png)|![](https://imgurl.xyz/images/2018/08/10/7844e91c44ac.md.png)|

# 简介

这是一个建议的新闻客户端 页面非常简单

通过网络请求加载 分类数据 和 分类详情数据  （key都在代码里了，轻量使用~）

UI上几乎是没有任何特点

使用BottomNavigationBar 分成3个控制器

首页使用DefaultTabController管理内容

相关依赖：
```
http: "^0.11.3"                   #网络请求
cached_network_image: "^0.4.1"    #图片加载
cupertino_icons: ^0.1.2           #icon
flutter_webview_plugin: ^0.1.6    #webview
shared_preferences: ^0.4.2        #持久化数据
url_launcher: ^3.0.3              #调用系统浏览器
```

# 代码

## 使用单例来保存数据
由于分类原则上是没有变化的，我这里就使用单例来保存从API请求的分类数据，减少请求次数（API请求次数有限）
```dart
class UserSinglen {
   List<WeType> allTypes = [];
  static final UserSinglen _singleton = new UserSinglen._internal();
  factory UserSinglen() {
    return _singleton;
  }
  UserSinglen._internal();
}
```

## 使用Shared保存数据
保存当前选中的分类
```dart
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
```

## BottomNavigationBar的使用

### 构建NavigationIcon
为底部的icon封装，方便找到对应的控制器
```dart
class NavigationIcon {
  NavigationIcon({
    Widget icon,
    Widget title,
    TickerProvider vsync,
  })  : item = new BottomNavigationBarItem(
          icon: icon,
          title: title,
        ),
        controller = new AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        );

  final BottomNavigationBarItem item;
  final AnimationController controller;
}
```

### 构建当前控制器
当前控制器是Stateful类型，刷新页面
初始化3个控制器
```dart
class Index extends StatefulWidget {
    const Index({ Key key }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new IndexState();
}

class IndexState extends State<Index> with TickerProviderStateMixin {
  List<NavigationIcon> navigationIcons;
  List<StatefulWidget> pageList;
  int currentPageIndex = 0;
  StatefulWidget currentWidget;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigationIcons = <NavigationIcon>[
      new NavigationIcon(
        icon: new Icon(Icons.home),
        title: new Text("首页"),
        vsync: this,
      ),
      new NavigationIcon(
        icon: new Icon(Icons.category),
        title: new Text("分类"),
        vsync: this,
      ),
      new NavigationIcon(
        icon: new Icon(Icons.info),
        title: new Text("关于"),
        vsync: this,
      )
    ];

    pageList = <StatefulWidget>[
      new Home(key: new Key("home"),),
      new Category(key: new Key("category"),),
      new About(),
    ];

    for(NavigationIcon view in navigationIcons) {
      view.controller.addListener(rebuild());
    }

    currentWidget = pageList[currentPageIndex];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for (NavigationIcon view in navigationIcons) {
      view.controller.dispose();
    }
  }

rebuild(){
  print("rebuild");
  setState(() {});
}

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      items: navigationIcons.map(((i) => i.item)).toList(),
      currentIndex: currentPageIndex,
      fixedColor: Config.mainColor,
      type: BottomNavigationBarType.fixed,
      onTap: (i) {
        setState(() {
          navigationIcons[i].controller.reverse();
          currentPageIndex = i;
          navigationIcons[i].controller.forward();
          currentWidget = pageList[i];
        });
      },
    );

    return new MaterialApp(
      theme: Config.themeData,
      home: new Scaffold(
        body: Center(
          child: currentWidget,
        ),
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
```

## 首页
首页实时获取存储在本地的已选择分类，与单例中的所有分类做对比，获取对应的类型id
（shared_preferences只能存储基本数据类型）

```dart
class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  bool _isloading = true;
  List<WeType> _list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    API.featchTypeListData((List<WeType> callback) {
      Shared.getSelectedType().then((onValue) {
        print(onValue);
        if (onValue != null) {
          print("lentch = ");
          print(onValue.length);
          setState(() {
            _isloading = false;
            _list = callback.where((t) => onValue.contains(t.id)).toList();
          });
        }
      });
    }, errorback: (error) {
      print("error:$error");
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _isloading
        ? new Scaffold(
            appBar: new AppBar(
              title: new Text("loading..."),
            ),
            body: new Center(
              child: new CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            ),
          )
        : new DefaultTabController(
            length: _list.length,
            child: new Scaffold(
                appBar: new AppBar(
                  title: new Text("新闻"),
                  bottom: new TabBar(
                      isScrollable: true,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: _list.map((f) => new Tab(text: f.name)).toList()),
                ),
                body: new TabBarView(
                  children:
                      _list.map((f) => new Content(channelId: f.id)).toList(),
                )),
          );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
```

## 分类
这个页面也很简单，将已选择的分类id存进shared_preferences中就行

```dart
class Category extends StatefulWidget {
  const Category({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new CategoryState();
}

class CategoryState extends State<Category> {
  List<WeType> _list = [];
  bool _isloading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    API.featchTypeListData((List<WeType> callback) {
      Shared.getSelectedType().then((onValue) {
        setState(() {
          _isloading = false;
          _list = callback
              .map((f) => new WeType(f.id, f.name, onValue.contains(f.id)))
              .toList();
        });
      });
    }, errorback: (error) {
      print("error:$error");
    });
  }

  _onTapButton(WeType type) {
    setState(() {
      _list = _list.map((WeType f) {
        if (f.id == type.id) {
          f.isSelected = !f.isSelected;
        }
        return f;
      }).toList();

      Shared.saveSelectedType(
          _list.where((t) => t.isSelected).map((f) => f.id).toList());
    });
  }

  _selectAll() {
    print("all");
    var r = _list.where((t) => t.isSelected).toList();
    bool res = r.length < _list.length ? true : false;

    setState(() {
      _list = _list.map((f) => new WeType(f.id, f.name, res)).toList();
      Shared.saveSelectedType(
          _list.where((t) => t.isSelected).map((f) => f.id).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isloading
        ? CircularProgressIndicator()
        : new Scaffold(
            appBar: new AppBar(
              title: new Text("分类"),
              actions: <Widget>[
                new FlatButton(
                  onPressed: _selectAll,
                  child: new Center(
                      child: new Text(
                    "全选",
                    style: new TextStyle(color: Colors.white),
                  )),
                )
              ],
            ),
            body: new GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this would produce 2 rows.
              crossAxisCount: 3,
              crossAxisSpacing: 0.0,
              childAspectRatio: 2.0,
              // Generate 100 Widgets that display their index in the List
              children: _list
                  .map((f) => new FlatButton(
                        padding: const EdgeInsets.all(10.0),
                        onPressed: () {
                          _onTapButton(f);
                        },
                        child: new Center(child: _Button(f.name, f.isSelected)),
                      ))
                  .toList(),
            ));
  }
}

class _Button extends StatelessWidget {
  final String title;
  final bool isSelected;
  _Button(this.title, this.isSelected);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        new Container(
          child: new Center(
            child: new Text(title),
          ),
          decoration: new BoxDecoration(
            color:  isSelected ? Colors.blue[200] : Colors.white,
            borderRadius: new BorderRadius.all(
              const Radius.circular(20.0),
            ),
            border: new Border.all(
                color: isSelected ? Colors.white : Colors.blue[100],//边框颜色
                width: 1.0,//边框宽度
              ),
          ),
        ),
        new Container(
          child: new Center(
            child: isSelected
                ? new Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : null,
          ),

        ),
      ],
    );

  }
}

```

# 代码地址

[Flutter-news](https://github.com/gongxiaokai/flutter-news)
欢迎点赞
