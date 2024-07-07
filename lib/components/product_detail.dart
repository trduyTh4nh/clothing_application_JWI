import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuan08/app/model/product.dart';
import 'package:tuan08/helper/db_helper.dart';
import 'package:tuan08/provider/add_provider.dart';
import 'package:tuan08/utils.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool checkfavorite = false;
  List<ProductModel> _list = [];
  Future<List<ProductModel>> _getProduct() async {
    return await _databaseHelper.products();
  }

  Future<void> _initializeProducts() async {
    _list = await _getProduct();
    for (var element in _list) {
      if (element.id == widget.productModel.id) {
        setState(() {
          checkfavorite = element.id == widget.productModel.id;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getProduct();
    _initializeProducts();
    // checkfavorite = false;
  }

  List<String> _sizes = ["S", "M", "L", "XL", "XXL"];
  DatabaseHelper _databaseHelper = DatabaseHelper();
  Future<void> _onSaveFavorite() async {
    ProductModel productModel = widget.productModel;
    await _databaseHelper.insertProduct(productModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productModel.name!),
        actions: [
          IconButton(
              onPressed: () {
                checkfavorite = !checkfavorite;
                _onSaveFavorite();
                setState(() {});
              },
              icon: checkfavorite
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.pinkAccent,
                    )
                  : const Icon(
                      Icons.favorite_border_outlined,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
                Container(
                  child: Hero(
                      tag: widget.productModel.id!,
                      child: Image.network(widget.productModel.imageURL!)),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              widget.productModel.name!,
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        formatMoney(widget.productModel.price!),
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                    child: SizedBox(
                        height: 70,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 10,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: _sizes.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: Container(
                                width: 70,
                                height: 70,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.black)),
                                child: Center(
                                  child: Text(_sizes[index]),
                                ),
                              ),
                            );
                          },
                        )),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: Consumer<ProductProvider>(
                      builder: (context, value, child) {
                        return FilledButton(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8), // Set the border radius to zero
                                ),
                              ),
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  Colors.black), // Change to your desired color
                            ),
                            onPressed: () {
                              value.add(widget.productModel);

                              snackAlert(
                                  "Thêm vào giỏ hàng thành công", context);
                            },
                            child: const Text("THÊM VÀO GIỎ HÀNG"));
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    widget.productModel.description != null
                        ? widget.productModel.description!
                        : "",
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
