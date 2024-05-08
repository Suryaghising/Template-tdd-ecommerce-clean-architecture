import '../error/exception.dart';

abstract class DummyCategoryService {
  List<dynamic> getCategories();
  Map<String, dynamic> getCategoryById(int id);
  Map<String, dynamic> addCategory(Map<String, dynamic> request);
  Map<String, dynamic> updateCategory(Map<String, dynamic> request);
  void deleteCategory(int id);
}

class DummyCategoryServiceImpl implements DummyCategoryService {
  // A dummy list of categories represented as JSON objects
  static List<Map<String, dynamic>> dummyCategories = [
    {
      'id': 1,
      'name': 'Electronics',
      'description': 'Electronic devices and gadgets'
    },
    {
      'id': 2,
      'name': 'Clothing',
      'description': 'Apparel and fashion accessories'
    },
    {'id': 3, 'name': 'Books', 'description': 'Books of various genres'},
    {
      'id': 4,
      'name': 'Home & Kitchen',
      'description': 'Household items and appliances'
    },
    {
      'id': 5,
      'name': 'Sports & Outdoors',
      'description': 'Sporting goods and outdoor equipment'
    },
  ];

  @override
  List<dynamic> getCategories() {
    // Returning a copy of the dummy categories list to prevent modifications
    return List<Map<String, dynamic>>.from(dummyCategories);
  }

  @override
  Map<String, dynamic> addCategory(Map<String, dynamic> category) {
    final existingIndex = dummyCategories.indexWhere((element) => element['name'] == category['name']);
    if(existingIndex >= 0) {
      throw DuplicateEntryException();
    }
      int newId = dummyCategories.isNotEmpty ? dummyCategories.last['id'] + 1 : 1;
    final newCategory = {...category, 'id': newId};
    dummyCategories.add(newCategory);
    return newCategory;
  }

  @override
  Map<String, dynamic> getCategoryById(int id) {
    final index = dummyCategories.indexWhere((element) => element['id'] as int == id);
    if(index >= 0) {
      return dummyCategories[index];
    } else {
      throw NotFoundException();
    }
  }

  @override
  Map<String, dynamic> updateCategory(Map<String, dynamic> updatedCategory) {
    int index = dummyCategories
        .indexWhere((category) => category['id'] == updatedCategory['id']);
    if (index != -1) {
      dummyCategories[index] = updatedCategory;
      return updatedCategory;
    } else {
      throw NotFoundException();
    }
  }

  @override
  void deleteCategory(int id) {
    int index = dummyCategories.indexWhere((category) => category['id'] == id);
    if (index < 0) {
      throw NotFoundException();
    }
    dummyCategories.removeWhere((category) => category['id'] == id);
  }
}
