
class WeType {
  String id = "";
  String name = "";
  bool isSelected = true;

  // WeType(this.id, this.name);

  WeType(this.id,this.name,this.isSelected);

  WeType.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}
