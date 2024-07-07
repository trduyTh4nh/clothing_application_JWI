import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuan08/app/data/api.dart';
import 'package:tuan08/app/model/category.dart';
import 'package:tuan08/utils.dart';

class UpdateCategoryPage extends StatefulWidget {
  const UpdateCategoryPage({super.key, required this.cateModel});
  final CategoryModel cateModel;

  @override
  State<UpdateCategoryPage> createState() => _UpdateCategoryPageState();
}

class _UpdateCategoryPageState extends State<UpdateCategoryPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  // List<CategoryModel> _listAllCategory = [];

  void updateCategory(BuildContext context) async {
    CategoryModel cate = widget.cateModel;
    String name = nameController.text;
    String desc = descController.text;
    String urlImage = imageController.text;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token")!;
    String accountID = pref.getString("accountID")!;

    String result = await APIRepository()
        .updateCategory(accountID, cate.id!, name, desc, urlImage, token);

    setState(() {});
    if (result == 'ok') {
      snackAlert("Cập nhật loại sản phẩm thành công!", context);

      setState(() {});
    } else {
      snackAlert("Cập nhật thất bại", context);
    }
  }

  String urlImage = "";

  @override
  void initState() {
    super.initState();
    CategoryModel cate = widget.cateModel!;
    nameController.text = widget.cateModel.name;
    descController.text = cate.desc == "" ? "" : cate.desc;
    imageController.text = widget.cateModel.imageURL!; 
  }

  String currentValue = "";
  @override
  Widget build(BuildContext context) {
    CategoryModel cate = widget.cateModel;

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
                height: 18,
              ),
              OutlinedButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // Set the border radius to zero
                      ),
                    ),
                  ),
                  onPressed: () {
                    updateCategory(context);
                  },
                  child: const Text("Chỉnh sửa loại sản phẩm"))
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
