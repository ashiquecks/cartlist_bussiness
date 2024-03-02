import 'package:cartlistmurchant/MODAL/conformOrderModal.dart';
import 'package:cartlistmurchant/MODAL/deliverOrderModal.dart';
import 'package:flutter/cupertino.dart';

class DeliverOrderProvider extends ChangeNotifier {
  List<DeliverOrderModal> _orderList = [];

  List<DeliverOrderModal> get postList => _orderList;

  setPostList(List<DeliverOrderModal> list) {
    _orderList.addAll(list);
    notifyListeners();
  }

  mergePostList(List<DeliverOrderModal> list) {
    _orderList = list;
    notifyListeners();
  }

  DeliverOrderModal getPostByIndex(int index) => _orderList[index];
}
