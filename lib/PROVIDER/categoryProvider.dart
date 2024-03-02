import 'package:cartlistmurchant/MODAL/categoryModal.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider extends ChangeNotifier {
  List<CategoryModal> _categoryList = [];

  List<CategoryModal> get postList => _categoryList;

  setPostList(List<CategoryModal> list) {
    _categoryList.addAll(list);
    notifyListeners();
  }

  mergePostList(List<CategoryModal> list) {
    _categoryList = list;
    notifyListeners();
  }

  CategoryModal getPostByIndex(int index) => _categoryList[index];
}
