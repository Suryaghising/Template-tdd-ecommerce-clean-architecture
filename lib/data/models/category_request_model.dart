class CategoryRequestModel {
  final String name;
  final String description;

  CategoryRequestModel({required this.name, required this.description});

  static Map<String, dynamic> toJson(CategoryRequestModel categoryRequestModel) {
    return {
      'name': categoryRequestModel.name,
      'description': categoryRequestModel.description
    };
  }

}