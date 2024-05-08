import 'package:template/core/services/dummy_category_service.dart';
import 'package:template/data/models/category_model.dart';
import 'package:template/data/models/category_request_model.dart';

import '../../domain/entities/category.dart';

abstract class CategoryRemoteDataSource {
  Future<List<Category>> getAllCategories();
  Future<Category> getCategoryById(int id);
  Future<Category> addCategory(CategoryRequestModel request);
  Future<Category> updateCategory(Category request);
  Future<bool> deleteCategory(int id);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {

  final DummyCategoryService dummyCategoryService;

  CategoryRemoteDataSourceImpl(this.dummyCategoryService);

  @override
  Future<Category> addCategory(CategoryRequestModel request) async{
    final response = dummyCategoryService.addCategory(CategoryRequestModel.toJson(request));
    return CategoryModel.fromJson(response);
  }

  @override
  Future<bool> deleteCategory(int id) async{
    dummyCategoryService.deleteCategory(id);
    return true;
  }

  @override
  Future<List<Category>> getAllCategories() async{
    final response = dummyCategoryService.getCategories();
    return response.map((e) => CategoryModel.fromJson(e)).toList();
  }

  @override
  Future<Category> getCategoryById(int id) async{
    final response = dummyCategoryService.getCategoryById(id);
    return CategoryModel.fromJson(response);
  }

  @override
  Future<Category> updateCategory(Category request) async{
    final categoryModel = CategoryModel(id: request.id, name: request.name, description: request.description);
    final response = dummyCategoryService.updateCategory(CategoryModel.toJson(categoryModel));
    return CategoryModel.fromJson(response);
  }

}