import 'package:flutter/material.dart';
import 'navigationIcon.dart';
import 'config.dart';
import 'home/home.dart';
import 'about/about.dart';
class Index extends StatefulWidget {
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
        icon: new Icon(Icons.info),
        title: new Text("关于"),
        vsync: this,
      )
    ];

    pageList = <StatefulWidget>[
      new Home(),
      new About(),
    ];

    // for(NavigationIcon view in navigationIcons) {
    //   view.controller.addListener(rebuild());
    // }

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

// rebuild(){
//   print("rebuild");
//   setState(() {});
// }

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
