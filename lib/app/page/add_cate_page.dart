import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuan08/app/data/api.dart';
import 'package:tuan08/app/model/category.dart';
import 'package:tuan08/utils.dart';

class AddCatePage extends StatefulWidget {
  const AddCatePage({super.key});

  @override
  State<AddCatePage> createState() => _AddCatePageState();
}

class _AddCatePageState extends State<AddCatePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  List<CategoryModel> _listAllCategory = [];

  Future<List<CategoryModel>> getListCategory() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String accountID = pref.getString("accountID")!;
    String token = pref.getString("token")!;
    return await APIRepository().getListCategory(accountID, token);
  }

  String urlImage = "";
  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm loại sản phẩm"),
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
                  labelText: "Tên loại sản phẩm",
                  icon: Icon(Icons.abc),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: descController,
                decoration: const InputDecoration(
                  labelText: "Mô tả loại sản phẩm",
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
                    child: urlImage.isNotEmpty
                        ? Image.network(urlImage)
                        : const Icon(Icons.image, size: 50),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
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
                  onPressed: () async {
                    String name = nameController.text;
                    String desc = descController.text;
                    String urlImage = imageController.text;
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    String token = pref.getString("token")!;
                    String accountID = pref.getString("accountID")!;

                    String result = await APIRepository()
                        .adCategory(name, desc, urlImage, accountID, token);

                    if(result == 'ok'){
                      snackAlert("Thêm loại sản phẩm thành công!", context);
                    }
                    else{
                      snackAlert("Thêm không thành công! :(", context);
                    }
                  },
                  child: const Text("Thêm loại sản phẩm"))
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

// int getIdFromName(List<CategoryModel> _list, String name) {
//   CategoryModel cate = _list.firstWhere((e) => e.name == name);

//   return cate.id!;
// }
