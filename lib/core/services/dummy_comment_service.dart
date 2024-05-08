import '../error/exception.dart';

abstract class DummyCommentService {
  List<dynamic> findCommentsByProductId(int id);
  Map<String, dynamic> createComment(Map<String, dynamic> request);
  Map<String, dynamic> updateComment(Map<String, dynamic> request);
  void deleteComment(int id);
  void reportComment(int id);
  List<dynamic> getAllComments();
  Map<String, dynamic> getCommentById(int id);
}

class DummyCommentServiceImpl implements DummyCommentService {
  List<dynamic> dummyComments = [
    {
      'id': 1,
      'user_id': 1,
      'product_id': 1,
      'content': 'Content 1',
      'created_at': '2022-01-02'
    },
    {
      'id': 2,
      'user_id': 1,
      'product_id': 1,
      'content': 'Content 2',
      'created_at': '2022-01-03'
    },
    {
      'id': 3,
      'user_id': 2,
      'product_id': 2,
      'content': 'Content 3',
      'created_at': '2022-01-04'
    },
  ];

  @override
  Map<String, dynamic> createComment(Map<String, dynamic> request) {
    int newId = dummyComments.isNotEmpty ? dummyComments.last['id'] + 1 : 1;
    final newProduct = {...request, 'id': newId};
    dummyComments.add(newProduct);
    return newProduct;
  }

  @override
  void deleteComment(int id) {
    int index = dummyComments.indexWhere((comment) => comment['id'] == id);
    if (index < 0) {
      throw NotFoundException();
    }
    dummyComments.removeWhere((comment) => comment['id'] == id);
  }

  @override
  List<dynamic> findCommentsByProductId(int id) {
    return dummyComments
        .where((comment) => (comment['product_id'] as int) == id)
        .toList();
  }

  @override
  void reportComment(int id) {
    int index = dummyComments.indexWhere((comment) => comment['id'] == id);
    if (index < 0) {
      throw NotFoundException();
    }
    dummyComments.removeWhere((comment) => comment['id'] == id);
  }

  @override
  Map<String, dynamic> updateComment(Map<String, dynamic> request) {
    int index = dummyComments
        .indexWhere((product) => product['id'] == request['id']);
    if (index != -1) {
      dummyComments[index] = request;
      return request;
    } else {
      throw NotFoundException();
    }
  }

  @override
  List getAllComments() {
    return List<Map<String, dynamic>>.from(dummyComments);
  }

  @override
  Map<String, dynamic> getCommentById(int id) {
    final index = dummyComments.indexWhere((element) => element['id'] as int == id);
    if(index >= 0) {
      return dummyComments[index];
    } else {
      throw NotFoundException();
    }
  }
}
