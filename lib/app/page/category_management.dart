import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuan08/app/data/api.dart';
import 'package:tuan08/app/model/category.dart';
import 'package:tuan08/app/model/product.dart';
import 'package:tuan08/utils.dart';

class CategoryManagement extends StatefulWidget {
  const CategoryManagement({super.key});

  @override
  State<CategoryManagement> createState() => _CategoryManagementState();
}

class _CategoryManagementState extends State<CategoryManagement> {
  

  List<CategoryModel> _listAllCategory = [];

  Future<List<CategoryModel>> getListCategory() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String accountID = pref.getString("accountID")!;
    String token = pref.getString("token")!;
    return await APIRepository().getListCategory(accountID, token);
  }

  void getCategoriesAll() async {
    _listAllCategory = await getListCategory();

    for (var element in _listAllCategory) {
      print(element.name);
    }
  }

  @override
  void initState() {
    super.initState();
    getCategoriesAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Quản lý sản phẩm"),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
          ],
        ),
        body: Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<CategoryModel>>(
                    future: getListCategory(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('Không có sản phẩm nào'));
                      }

                      List<CategoryModel> result = snapshot.data!;

                      return ListView.separated(
                        separatorBuilder: (context, index) => Divider(),
                        physics:
                            NeverScrollableScrollPhysics(), // Disable scrolling for ListView
                        shrinkWrap: true, // Shrink the ListView to its content
                        itemCount: result.length,
                        itemBuilder: (context, index) {
                          CategoryModel product = result[index];
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
                                        Text(product.name!),
                                        const SizedBox(height: 4),
                                        // Text(formatMoney(product.price!)),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.edit),
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          Icons.delete_forever_outlined),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
