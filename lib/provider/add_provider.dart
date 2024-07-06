import 'package:flutter/material.dart';
import 'package:tuan08/app/model/product.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> lst = [];
  int price = 0;
  add(ProductModel mo) {
    lst.add(mo);
    price += mo.price!;
    notifyListeners();
  }

  del(int index) {
    if (lst.length == 1) {
      delAll();
    } else {
      lst.removeAt(index);
      if (price > 0) {
        print(lst.elementAt(index).price);
        price -= lst.elementAt(index).price!;
      }
    }
    notifyListeners();
  }

  delAll() {
    lst = [];
    price = 0;
    notifyListeners();
  }

  
}
