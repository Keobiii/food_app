class CategoryModel {
  String image, name;

  CategoryModel({required this.image, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(image: json['image'] ?? "", 
    name: json['name'] ?? "");
  }
}