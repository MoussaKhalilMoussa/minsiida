class Category {
  int? id;
  String? name;
  String? description;
  String? icon;
  List<Subcategory>? subcategories;

  Category({
    this.id,
    this.name,
    this.description,
    this.icon,
    this.subcategories,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    icon = json['icon'];
    if (json['subcategories'] != null) {
      subcategories = <Subcategory>[];
      json['subcategories'].forEach((v) {
        subcategories!.add(Subcategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['icon'] = icon;
    if (subcategories != null) {
      data['subcategories'] = subcategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return "name:$name, icon:$icon";
  }
}

class Subcategory {
  int? id;
  String? name;
  String? description;
  String? icon;
  int? categoryId;

  Subcategory({
    this.id,
    this.name,
    this.description,
    this.icon,
    this.categoryId,
  });

  Subcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    icon = json['icon'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['icon'] = icon;
    data['categoryId'] = categoryId;
    return data;
  }
}
