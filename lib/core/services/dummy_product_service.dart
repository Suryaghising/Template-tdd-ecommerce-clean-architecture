import '../error/exception.dart';

abstract class DummyProductService {
  List<dynamic> getAllProducts();
  Map<String, dynamic> getProductById(int id);
  Map<String, dynamic> addProduct(Map<String, dynamic> request);
  Map<String, dynamic> updateProduct(Map<String, dynamic> request);
  void deleteProduct(int id);
}

class DummyProductServiceImpl implements DummyProductService {
  List<dynamic> dummyProducts = [
    {
      'id': 1,
      'name': 'Iphone',
      'price': 200000,
      'description': 'This is iphone 14.',
      'image_url': 'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-card-40-iphone15prohero-202309_FMT_WHH?wid=508&hei=472&fmt=p-jpg&qlt=95&.v=1693086369818'
    },
    {
      'id': 2,
      'name': 'Samsung',
      'price': 115000,
      'description': 'This is Samsung S24',
      'image_url': 'https://media.cnn.com/api/v1/images/stellar/prod/samsung-galaxy-s24-ultra-product-card-v2-cnnu.jpg?c=16x9&q=h_720,w_1280,c_fill'
    },
    {
      'id': 3,
      'name': 'Pixel',
      'price': 80000,
      'description': 'This is pixel 8.',
      'image_url': 'https://m.media-amazon.com/images/I/713eEl39eLL._AC_SL1500_.jpg'
    },
  ];

  @override
  Map<String, dynamic> addProduct(Map<String, dynamic> request) {
    final existingIndex = dummyProducts.indexWhere((element) => element['name'] == request['name']);
    if(existingIndex >= 0) {
      throw DuplicateEntryException();
    }
    int newId = dummyProducts.isNotEmpty ? dummyProducts.last['id'] + 1 : 1;
    final newProduct = {...request, 'id': newId};
    dummyProducts.add(newProduct);
    return newProduct;
  }

  @override
  void deleteProduct(int id) {
    int index = dummyProducts.indexWhere((product) => product['id'] == id);
    if (index < 0) {
      throw NotFoundException();
    }
    dummyProducts.removeWhere((product) => product['id'] == id);
  }

  @override
  List getAllProducts() {
    return List<Map<String, dynamic>>.from(dummyProducts);
  }

  @override
  Map<String, dynamic> getProductById(int id) {
    final index = dummyProducts.indexWhere((element) => element['id'] as int == id);
    if(index >= 0) {
      return dummyProducts[index];
    } else {
      throw NotFoundException();
    }
  }

  @override
  Map<String, dynamic> updateProduct(Map<String, dynamic> request) {
    int index = dummyProducts
        .indexWhere((product) => product['id'] == request['id']);
    if (index != -1) {
      dummyProducts[index] = request;
      return request;
    } else {
      throw NotFoundException();
    }
  }
}
