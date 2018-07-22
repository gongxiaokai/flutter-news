import 'package:flutter/material.dart';
import 'package:news/config.dart';
import 'package:news/home/model/weType.dart';
import 'package:news/shared.dart';
import 'package:news/api/api.dart';

class Category extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return _isloading
        ? CircularProgressIndicator()
        : new Scaffold(
            appBar: new AppBar(
              title: new Text("分类"),
            ),
            body: new GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this would produce 2 rows.
              crossAxisCount: 3,
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
    return new Row(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.only(left: 10.0),
          width: 70.0,
          child: new Center(child: new Text(title)),
        ),
        new Container(
          child: new Icon(Icons.check_circle,
              color: isSelected ? Colors.blue : Colors.black12),
        )
      ],
    );
  }
}
