import 'package:flutter/material.dart';
import 'package:news/config.dart';
import 'package:news/home/model/weType.dart';
import 'package:news/shared.dart';
import 'package:news/api/api.dart';

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
    UserSinglen singlen = new UserSinglen();
    List<WeType> allTypes = singlen.allTypes;

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
      alignment: AlignmentDirectional.centerEnd,
      children: <Widget>[
        new Container(
          width: ((MediaQuery.of(context).size.width/3) - 50),
          child: new Text(title,style: TextStyle(fontSize: 18.0),),
        ),
        new Container(
          child: new Icon(Icons.check_circle,
              color: isSelected ? Colors.blue : Colors.black12),
        )
      ],
    );

    // return new Row(
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: <Widget>[
    //     new Container(
    //       color: Colors.yellow,
    //       width: MediaQuery.of(context).size.width / 3 - 70,
    //       child: new Center(child: new Text(title)),
    //     ),
    //     new Container(
    //       width: 10.0,
    //       child: new Icon(Icons.check_circle,
    //           color: isSelected ? Colors.blue : Colors.black12),
    //     )
    //   ],
    // );
  }
}
