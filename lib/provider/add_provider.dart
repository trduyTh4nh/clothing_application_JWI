import 'package:flutter/material.dart';
import 'package:tuan08/app/model/product.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> lst = [];
  add(ProductModel mo) {
    lst.add(mo);
    notifyListeners();
  }

  del(int index) {
    lst.removeAt(index);
    notifyListeners();
  }

  delAll() {
    lst = [];
    notifyListeners();
  }
}
