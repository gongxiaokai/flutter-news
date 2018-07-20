
class WeType {
  String id;
  String name;

  WeType(this.id, this.name);

  WeType.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}

// class WeTypeList {
//   List<WeType> types;

//   WeTypeList():types=[];

//   WeTypeList.fromJson(Map<String,dynamic> j) {
//     types = [];
//     // int count = 0;
//     for (var item in j['showapi_res_body']['typeList']) {
//       // if (count < 5) {
//       types.add(WeType.fromJson(item));
//       // }
//       // count = count + 1;
//     }
//   }
// }
 