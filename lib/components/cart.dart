import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuan08/app/data/api.dart';
import 'package:tuan08/app/model/order.dart';
import 'package:tuan08/app/model/product.dart';
import 'package:tuan08/provider/add_provider.dart';
import 'package:tuan08/utils.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
  }

  showAlertDialog(BuildContext context, ProductProvider value) async {
    Widget cancelButton = TextButton(
      child: const Text("Hủy"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Đồng ý"),
      onPressed: () async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        String token = pref.getString("token")!;
        List<ProductModel> productModel = value.lst;
        List<Order> _orders = [];
        List<int> _idProductCarts = [];

        for (int i = 0; i < productModel.length; i++) {
          bool isDuplicate = false;
          for (int j = i + 1; j < productModel.length; j++) {
            if (productModel[i] == productModel[j]) {
              isDuplicate = true;
              break;
            }
          }
          if (!isDuplicate) {
            _idProductCarts.add(productModel[i].id!);
          }
        }
        if (!_idProductCarts.contains(productModel.last.id)) {
          _idProductCarts.add(productModel.last.id!);
        }
        for (var element in _idProductCarts) {
          int count = 0;
          for (int i = 0; i < productModel.length; i++) {
            if (element == productModel[i].id) {
              count++;
            }
          }
          _orders.add(Order(id: element, count: count));
        }

        String result = await APIRepository().paymentCart(_orders, token);

        if (result == "ok") {
          snackAlert("Thanh toán thành công", context);
        } else {
          snackAlert("Thanh toán thất bại!", context);
        }

        setState(() {});

        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Bạn có chắc?"),
      content: const Text("Bạn có chắc muốn thanh toán!??"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giỏ hàng"),
        actions: [
          Consumer<ProductProvider>(
            builder: (context, value, child) {
              return IconButton(
                  onPressed: () {
                    value.delAll();
                    setState(() {});
                  },
                  icon: const Icon(Icons.delete));
            },
          )
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, value, child) {
          return ListView.separated(
              itemBuilder: (context, index) {
                ProductModel product = value.lst[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 50,
                            height: 50,
                            child: Image.network(product.imageURL!),
                          ),
                          const SizedBox(width: 6),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(width: 250, child: Text(product.name!)),
                              const SizedBox(height: 4),
                              Text(formatMoney(product.price!)),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            value.del(index);
                            setState(() {});
                          },
                          icon: const Icon(Icons.delete_sharp))
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: value.lst.length);
        },
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(color: Colors.black12),
        height: 120,
        width: double.infinity,
        child: Consumer<ProductProvider>(
          builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tổng tiền",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(formatMoney(value.price),
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold))
                  ],
                ),
                ElevatedButton(
                    onPressed: () async {
                      showAlertDialog(context, value);
                      // SharedPreferences pref =
                      //     await SharedPreferences.getInstance();
                      // String token = pref.getString("token")!;
                      // List<ProductModel> productModel = value.lst;
                      // List<Order> _orders = [];
                      // List<int> _idProductCarts = [];

                      // for (int i = 0; i < productModel.length; i++) {
                      //   bool isDuplicate = false;
                      //   for (int j = i + 1; j < productModel.length; j++) {
                      //     if (productModel[i] == productModel[j]) {
                      //       isDuplicate = true;
                      //       break;
                      //     }
                      //   }
                      //   if (!isDuplicate) {
                      //     _idProductCarts.add(productModel[i].id!);
                      //   }
                      // }
                      // if (!_idProductCarts.contains(productModel.last.id)) {
                      //   _idProductCarts.add(productModel.last.id!);
                      // }
                      // for (var element in _idProductCarts) {
                      //   int count = 0;
                      //   for (int i = 0; i < productModel.length; i++) {
                      //     if (element == productModel[i].id) {
                      //       count++;
                      //     }
                      //   }
                      //   _orders.add(Order(id: element, count: count));
                      // }

                      // String result =
                      //     await APIRepository().paymentCart(_orders, token);

                      // if (result == "ok") {
                      //   snackAlert("Thanh toán thành công", context);
                      // } else {
                      //   snackAlert("Thanh toán thất bại!", context);
                      // }
                    },
                    child: const Text("Thanh toán"))
              ],
            );
          },
        ),
      ),
    );
  }
}
