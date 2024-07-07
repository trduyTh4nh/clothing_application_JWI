import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuan08/app/data/api.dart';
import 'package:tuan08/app/model/category.dart';
import 'package:tuan08/app/model/product.dart';
import 'package:tuan08/utils.dart';

class UpdateProductPage extends StatefulWidget {
  const UpdateProductPage({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  List<CategoryModel> _listAllCategory = [];

  Future<List<CategoryModel>> getListCategory() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String accountID = pref.getString("accountID")!;
    String token = pref.getString("token")!;
    return await APIRepository().getListCategory(accountID, token);
  }

  void updateProduct(BuildContext context) async {
    String nameProduct = nameController.text;
    String descProduct = descController.text;
    String urlImage = imageController.text;
    String price = priceController.text;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token")!;
    String accountID = pref.getString("accountID")!;

    if (await APIRepository().updateProduct(
            accountID,
            widget.productModel.id!,
            nameProduct,
            descProduct,
            urlImage,
            double.parse(price),
            widget.productModel.categoryID.toString(),
            token) ==
        200) {
      snackAlert("Chỉnh sửa thành công!", context);
    }
  }

  String urlImage = "";

  @override
  void initState() {
    super.initState();
    nameController.text = widget.productModel.name!;
    descController.text = widget.productModel.description == null ? "" : widget.productModel.description!;
    imageController.text = widget.productModel.imageURL!;
    priceController.text = widget.productModel.price.toString();
  }

  List<CategoryModel> test = [];
  void getCategoriesAll() async {
    _listAllCategory = await getListCategory();

    for (var element in _listAllCategory) {
      print(element.name);
    }
  }

  String currentValue = "";
  @override
  Widget build(BuildContext context) {
    ProductModel product = widget.productModel;

    return Scaffold(
      appBar: AppBar(
        title: Text("Chỉnh sửa sản phẩm"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Tên sản phẩm",
                  icon: Icon(Icons.abc),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: descController,
                decoration: const InputDecoration(
                  labelText: "Mô tả sản phẩm",
                  icon: Icon(Icons.description),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: imageController,
                                decoration: const InputDecoration(
                                  labelText: "URL Hình ảnh",
                                  icon: Icon(Icons.image),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            FilledButton(
                              onPressed: () {
                                setState(() {
                                  urlImage = imageController.text;
                                });
                              },
                              child: const Text("Preview"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: priceController,
                          decoration: const InputDecoration(
                            labelText: "Giá",
                            icon: Icon(Icons.money),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 100,
                    height: 100,
                    child: Image.network(imageController.text),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              FutureBuilder<List<CategoryModel>>(
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
                  List<String> _names = result.map((e) => e.name).toList();
                  CategoryModel cate = result.firstWhere(
                      (e) => e.id == widget.productModel.categoryID!);
                  return DropdownButton(
                    onChanged: (value) {
                      print(value);
                      test = result;
                      currentValue = value!;
                      setState(() {});
                    },
                    value: _names.contains(currentValue) ? currentValue : null,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    items: _names.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              child: Image.network(
                                  getImageFromName(result, value)),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(value),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(
                height: 18,
              ),
              OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // Set the border radius to zero
                      ),
                    ),
                  ),
                  onPressed: () {
                    updateProduct(context);
                  },
                  child: const Text("Chỉnh sửa sản phẩm"))
            ],
          ),
        ),
      ),
    );
  }
}

String getImageFromName(List<CategoryModel> _list, String name) {
  CategoryModel cate = _list.firstWhere((e) => e.name == name);

  return cate.imageURL!;
}

int getIdFromName(List<CategoryModel> _list, String name) {
  CategoryModel cate = _list.firstWhere((e) => e.name == name);

  return cate.id!;
}
