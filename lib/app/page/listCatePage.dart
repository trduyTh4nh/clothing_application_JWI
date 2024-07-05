import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuan08/app/data/api.dart';
import 'package:tuan08/app/model/category.dart';

class Listcatepage extends StatefulWidget {
  const Listcatepage({super.key});

  @override
  State<Listcatepage> createState() => _ListcatepageState();
}

class _ListcatepageState extends State<Listcatepage> {
  List<CategoryModel> _listCateModel = [];

  Future<List<CategoryModel>> getListCategory() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String accountID = pref.getString("accountID")!;
    String token = pref.getString("token")!;

    return await APIRepository().getListCategory(accountID, token);
  }

  void getAllListCate() async {
    _listCateModel = await getListCategory();
    for (var element in _listCateModel) {
      print(element.name);
    }
  }

  @override
  void initState() {
    super.initState();
    getAllListCate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List category product"),
      ),
      body: FutureBuilder(
          future: getListCategory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  itemCount: _listCateModel.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        
                        child: Container(
                          
                          child: CircleAvatar(backgroundImage: NetworkImage(_listCateModel[index].imageURL!),),
                      ),
                    ));
                  },
                ),
              ),
            );
          }),
    );
  }
}
