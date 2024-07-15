import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tuan08/app/page/forgetpassword.dart';
import 'package:tuan08/app/page/listCatePage.dart';
import 'package:tuan08/components/management.dart';
import 'package:tuan08/components/update_infomation.dart';
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
                                  color:
                                      const Color.fromARGB(255, 190, 190, 190)
                                          .withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(user.imageURL!, scale: 1),
                              radius: 60,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              Text("Number: ${user.idNumber}", style: mystyle),
                              Text("Tên đầy đủ: ${user.fullName}",
                                  style: mystyle),
                              Text("Số điện thoại: ${user.phoneNumber}",
                                  style: mystyle),
                              Text("Giới tính: ${user.gender}", style: mystyle),
                              Text("Ngày sinh: ${user.birthDay}",
                                  style: mystyle),
                              Text("Năm học: ${user.schoolYear}",
                                  style: mystyle),
                              Text("Khóa học: ${user.schoolKey}",
                                  style: mystyle),
                              Text("Ngày tạo: ${user.dateCreated}",
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
                Column(
                  
                  children: [
                    FilledButton.icon(
                      icon: const Icon(Icons.key),
                      label: const Text("Quên mật khẩu"),
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8), 
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
                      
                    ),
                    // OutlinedButton(
                    //   style: ButtonStyle(
                    //     shape: WidgetStateProperty.all(
                    //       RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(
                    //             8), // Set the border radius to zero
                    //       ),
                    //     ),
                    //   ),
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => const Listcatepage(),
                    //       ),
                    //     );
                    //   },
                    //   child: const Text("List Category"),
                    // ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.shield_moon_outlined),
                      label: const Text("Chế độ quản trị viên"),
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
                 
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.person_pin),
                      label: const Text('Chỉnh sửa thông tin'),
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
                            builder: (context) => const UpdateInfomationPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Container(
                    child: Lottie.asset("assets/images/use_interface.json"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
