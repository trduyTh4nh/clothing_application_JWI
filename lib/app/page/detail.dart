import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tuan08/app/page/forgetpassword.dart';
import 'package:tuan08/app/page/listCatePage.dart';
import 'package:tuan08/components/management.dart';
import '../model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String myToken = "";
  // khi dùng tham số truyền vào phải khai báo biến trùng tên require
  User user = User.userEmpty();
  getDataUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String strUser = pref.getString('user')!;
    myToken = pref.getString("token")!;

    user = User.fromJson(jsonDecode(strUser));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    getDataUser();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle mystyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  width: 500,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 190, 190, 190)
                                      .withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(user.imageURL!, scale: 1),
                              radius: 60,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              Text("NumberID: ${user.idNumber}",
                                  style: mystyle),
                              Text("Fullname: ${user.fullName}",
                                  style: mystyle),
                              Text("Phone Number: ${user.phoneNumber}",
                                  style: mystyle),
                              Text("Gender: ${user.gender}", style: mystyle),
                              Text("Birth Day: ${user.birthDay}",
                                  style: mystyle),
                              Text("School Year: ${user.schoolYear}",
                                  style: mystyle),
                              Text("School Key: ${user.schoolKey}",
                                  style: mystyle),
                              Text("Date Created: ${user.dateCreated}",
                                  style: mystyle),
                              const SizedBox(height: 16),
                            ],
                          )
                        ], 
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilledButton(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8), // Set the border radius to zero
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Forgetpassword(),
                          ),
                        );
                      },
                      child: const Text("Forget Password"),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Listcatepage(),
                          ),
                        );
                      },
                      child: const Text("List Category"),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ManagementPage(),
                          ),
                        );
                      },
                      child: const Text("CRUD"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
