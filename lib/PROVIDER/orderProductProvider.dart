import 'package:cartlistmurchant/MODAL/categoryModal.dart';
import 'package:cartlistmurchant/MODAL/orderModal.dart';
import 'package:cartlistmurchant/MODAL/stockProductModal.dart';
import 'package:flutter/cupertino.dart';

class OrderProductProvider extends ChangeNotifier {
  List<StockProductModal> _orderProductList = [];

  List<StockProductModal> get postList => _orderProductList;

  setPostList(List<StockProductModal> list) {
    _orderProductList.addAll(list);
    notifyListeners();
  }

  mergePostList(List<StockProductModal> list) {
    _orderProductList = list;
    notifyListeners();
  }

  StockProductModal getPostByIndex(int index) => _orderProductList[index];
}
