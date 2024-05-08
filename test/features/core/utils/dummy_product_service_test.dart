import 'package:flutter_test/flutter_test.dart';
import 'package:template/core/error/exception.dart';
import 'package:template/core/services/dummy_product_service.dart';

void main() {
  late DummyProductService dummyProductService;

  setUp(() {
    dummyProductService = DummyProductServiceImpl();
  });

  List<dynamic> expectedProducts = [
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

  group('getProducts', () {
    test('should return a list of dummy products', () {
      // Act
      final products = dummyProductService.getAllProducts();

      // Assert
      expect(products, equals(expectedProducts));
    });

  });

  group('getProductById', () {
    int id = 1;
    test('should return product with matching id', () {
      // act
      final product = dummyProductService.getProductById(id);
      // assert
      expect(product, isNotNull);
    });

    test('should throw NotFoundException for non-existent id', () {
      // assert
      expect(() => dummyProductService.getProductById(8), throwsA(isA<NotFoundException>()));
    });
  });

  group('addProduct', () {
    test('should add a new product to the list', () {
      // Arrange
      final newProduct = {'id': 8, 'name': 'Product 8', 'price': 1040, 'description': 'Description 8', 'image_url': 'Image 8'};
      final initialProducts = dummyProductService.getAllProducts();

      // Act
      dummyProductService.addProduct(newProduct);
      final productsAfterAddition = dummyProductService.getAllProducts();
      final addedProduct = productsAfterAddition.firstWhere((product) => product['id'] == 4);
      // Assert
      expect(addedProduct, isNotNull);
      expect(productsAfterAddition.length, equals(initialProducts.length + 1));
    });

    test('should throw duplicate entry exception when product name already exists', () {
      // arrange
      final newProduct = {'id': 3, 'name': 'Samsung', 'price': 1040, 'description': 'Description 3', 'image_url': 'Image 3'};

      // assert
      expect(() =>dummyProductService.addProduct(newProduct), throwsA(isA<DuplicateEntryException>()));
    });
  });

  group('updateProduct', () {
    test('should update the product with matching id', () {
      // Arrange
      final updatedProduct = {'id': 2, 'name': 'Product 2', 'price': 1040, 'description': 'Updated Description', 'image_url': 'Updated Image'};

      // Act
      dummyProductService.updateProduct(updatedProduct);
      final updatedProductFromService = dummyProductService.getProductById(2);

      // Assert
      expect(updatedProductFromService, equals(updatedProduct));
    });

    test('updateProduct should throw NotFoundException for non-existent id', () {
      // Arrange
      final nonExistentProduct = {'id': 10, 'name': 'Product 10', 'price': 10, 'description': 'Description 10', 'image_url': 'Image 10'};

      // Act & Assert
      expect(() => dummyProductService.updateProduct(nonExistentProduct), throwsA(isA<NotFoundException>()));
    });
  });


  group('deleteProduct', () {
    test('should remove the product with matching id', () {
      // Arrange
      int id = 2;
      final products = dummyProductService.getAllProducts();
      // Act
      dummyProductService.deleteProduct(id);
      final productsAfterDeletion = dummyProductService.getAllProducts();
      int index = productsAfterDeletion.indexWhere((element) => element['id'] as int == id);
      // Assert
      expect(index, -1);
      expect(productsAfterDeletion.length, products.length-1);
    });


    test('deleteProduct should throw an exception for non-existent id', () {
      // Act & Assert
      expect(() => dummyProductService.deleteProduct(10), throwsA(isA<NotFoundException>()));
    });
  });

}
