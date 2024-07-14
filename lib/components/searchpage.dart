import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuan08/app/data/api.dart';
import 'package:tuan08/app/model/product.dart';
import 'package:tuan08/components/product_detail.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  TextEditingController search = TextEditingController();

  List<ProductModel> _listProduct = [];
  // List<ProductModel> _listSearch = [];
  List<ProductModel> _searchResult = [];

  Future<List<ProductModel>> getListProduct() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String accountID = pref.getString('accountID')!;
    String token = pref.getString('token')!;

    return await APIRepository().getListProduct(accountID, token);
  }

  void getAllListProduct() async {
    _listProduct = await getListProduct();
    // _listSearch = await getListProduct();

    setState(() {
      _searchResult = List.from([]);
    });
  }

  void fliterSearchResult(String query) {
    List<ProductModel> _listSearch = [];
    _listSearch.addAll(_listProduct);

    if (query.isNotEmpty) {
      List<ProductModel> _listData = [];
      _listSearch.forEach((item) {
        if (item.name!.toLowerCase().contains(query.toLowerCase())) {
          _listData.add(item);
        }
      });

      setState(() {
        _searchResult.clear();
        _searchResult.addAll(_listData);
      });
    } else {
      setState(() {
        _searchResult.clear();
        _searchResult.addAll([]);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAllListProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 50,
          child: TextField(
            onChanged: (value) {
              fliterSearchResult(value);
            },
            controller: search,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: _searchResult.isNotEmpty
            ? ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
                itemCount: _searchResult.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetail(
                                productModel: _searchResult[index]),
                          ));
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.16),
                              blurRadius: 4,
                              spreadRadius: 0,
                              offset: Offset(
                                0,
                                1,
                              ),
                            ),
                          ], borderRadius: BorderRadius.circular(20)),
                          width: 100,
                          height: 100,
                          child: Image.network(_searchResult[index].imageURL!),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _searchResult[index].name!,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                _searchResult[index].description ?? '',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : const Center(
                child: Text(
                  "Không tìm thấy sản phẩm nào? 🥺🥺",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
      ),
    );
  }
}
