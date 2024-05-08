import 'package:template/core/services/dummy_product_service.dart';
import 'package:template/data/models/product_model.dart';
import 'package:template/data/models/product_request_model.dart';
import 'package:template/domain/entities/product.dart';

abstract class ProductRemoteDataSource {
  Future<List<Product>> getAllProducts();
  Future<Product> getProductById(int id);
  Future<Product> addProduct(ProductRequestModel product);
  Future<Product> updateProduct(Product product);
  Future<bool> deleteProduct(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {

  final DummyProductService dummyProductService;

  ProductRemoteDataSourceImpl(this.dummyProductService);

  @override
  Future<Product> addProduct(ProductRequestModel product) async{
    final response = dummyProductService.addProduct(ProductRequestModel.toJson(product));
    return ProductModel.fromJson(response);
  }

  @override
  Future<bool> deleteProduct(int id) async{
    dummyProductService.deleteProduct(id);
    return true;
  }

  @override
  Future<List<Product>> getAllProducts() async{
    final products = dummyProductService.getAllProducts();
    return products.map((e) => ProductModel.fromJson(e)).toList();
  }

  @override
  Future<Product> getProductById(int id) async{
    final product = dummyProductService.getProductById(id);
    return ProductModel.fromJson(product);
  }

  @override
  Future<Product> updateProduct(Product product) async{
    final productModel = ProductModel(id: product.id, name: product.name, price: product.price, description: product.description, imageUrl: product.imageUrl);
    final response = dummyProductService.updateProduct(ProductModel.toJson(productModel));
    return ProductModel.fromJson(response);

  }

}