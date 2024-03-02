import 'package:cartlistmurchant/MODAL/categoryModal.dart';
import 'package:cartlistmurchant/MODAL/orderModal.dart';
import 'package:flutter/cupertino.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderModal> _orderList = [];

  List<OrderModal> get postList => _orderList;

  setPostList(List<OrderModal> list) {
    _orderList.addAll(list);
    notifyListeners();
  }

  mergePostList(List<OrderModal> list) {
    _orderList = list;
    notifyListeners();
  }

  OrderModal getPostByIndex(int index) => _orderList[index];
}
