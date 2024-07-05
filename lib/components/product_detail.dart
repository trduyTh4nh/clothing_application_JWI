import 'package:flutter/material.dart';
import 'package:tuan08/app/model/product.dart';
import 'package:tuan08/utils.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool checkfavorite = false;

  @override
  void initState() {
    super.initState();
    checkfavorite = false;
  }

  List<String> _sizes = ["S", "M", "L", "XL", "XXL"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productModel.name!),
        actions: [
          IconButton(
              onPressed: () {
                checkfavorite = !checkfavorite;
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
                  child: Image.network(widget.productModel.imageURL!),
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
                      Text(formatMoney(widget.productModel.price!))
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
                    height: 80,
                    width: 300,
                    child: FilledButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8), // Set the border radius to zero
                            ),
                          ),
                          backgroundColor: WidgetStateProperty.all<Color>(
                              Colors.black), // Change to your desired color
                        ),
                        onPressed: () {},
                        child: Text("THÊM VÀO GIỎ HÀNG")),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    widget.productModel.description!,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
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
