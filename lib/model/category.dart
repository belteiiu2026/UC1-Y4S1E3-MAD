
class Category {

  int? id;
  String? name;

  Category({this.id, this.name});

  Map<String, dynamic> toMap() => {
      "id" : id,
      "name" : name
    };

  factory Category.fromMap(Map<String,dynamic> map) =>
      Category(
        id: map["id"],
        name: map["name"]
      );

}