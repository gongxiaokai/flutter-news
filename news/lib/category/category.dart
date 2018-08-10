import 'package:flutter/material.dart';
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
