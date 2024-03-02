import 'package:cartlistmurchant/MODAL/conformOrderModal.dart';
import 'package:flutter/cupertino.dart';

class ConfirmOrderProvider extends ChangeNotifier {
  List<ConfirmOrderModal> _orderList = [];

  List<ConfirmOrderModal> get postList => _orderList;

  setPostList(List<ConfirmOrderModal> list) {
    _orderList.addAll(list);
    notifyListeners();
  }

  mergePostList(List<ConfirmOrderModal> list) {
    _orderList = list;
    notifyListeners();
  }

  ConfirmOrderModal getPostByIndex(int index) => _orderList[index];
}
