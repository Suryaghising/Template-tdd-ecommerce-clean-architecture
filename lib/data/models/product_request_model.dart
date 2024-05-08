class ProductRequestModel {
  final String name;
  final double price;
  final String description;
  final String imageUrl;

  ProductRequestModel(
      {required this.name,
      required this.price,
      required this.description,
      required this.imageUrl});

  static Map<String, dynamic> toJson(ProductRequestModel productRequest) {
    return {
      'name': productRequest.name,
      'price': productRequest.price,
      'description': productRequest.description,
      'image_url': productRequest.imageUrl
    };
  }
}
