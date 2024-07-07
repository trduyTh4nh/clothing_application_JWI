import 'package:flutter/material.dart';
import 'package:tuan08/app/model/product.dart';
import 'package:tuan08/helper/db_helper.dart';
import 'package:tuan08/utils.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<ProductModel> _list = [];
  Future<List<ProductModel>> _getProduct() async {
    return await _databaseHelper.products();
  }

  Future<void> removeProductFavorite(int id) async {
    await _databaseHelper.deleteProductFavorite(id);
    setState(() {});
  }

  @override
  void initState() {
    _getProduct();
    // _list = _getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Favorite"),
        ),
        body: FutureBuilder<List<ProductModel>>(
          future: _getProduct(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return snapshot.hasData
                ? Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListView.separated(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final product = snapshot.data![index];

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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(product.name!),
                                        width: 250,
                                        ),
                                      const SizedBox(height: 4),
                                      Text(formatMoney(product.price!)),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      removeProductFavorite(product.id!);
                                      setState(() {
                                        
                                      });
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                    ),
                  )
                : const Center(
                    child: Text("Không có sản phẩm được yêu thích nào"),
                  );
          },
        ));
  }
}
