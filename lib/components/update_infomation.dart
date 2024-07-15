import 'package:flutter/material.dart';

class UpdateInfomationPage extends StatefulWidget {
  const UpdateInfomationPage({super.key});

  @override
  State<UpdateInfomationPage> createState() => _UpdateInfomationPageState();
}

class _UpdateInfomationPageState extends State<UpdateInfomationPage> {
  TextEditingController numberID = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController birthDay = TextEditingController();
  TextEditingController schoolYear = TextEditingController();
  TextEditingController schoolKey = TextEditingController();
  TextEditingController imageURL = TextEditingController();
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chỉnh sửa thông tin cá nhân 🤵"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: numberID,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "numberID",
                  icon: Icon(Icons.account_balance),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: fullName,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Họ và tên",
                  icon: Icon(Icons.abc),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: phoneNumber,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Số điện thoại",
                  icon: Icon(Icons.phone_android),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      title: const Text(
                        'Nam',
                        style: TextStyle(fontSize: 12),
                      ),
                      leading: Radio<String>(
                        value: 'Nam',
                        groupValue: _selectedGender,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text(
                        'Nữ',
                        style: TextStyle(fontSize: 12),
                      ),
                      leading: Radio<String>(
                        value: 'Nữ',
                        groupValue: _selectedGender,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text(
                        'Khác',
                        style: TextStyle(fontSize: 12),
                      ),
                      leading: Radio<String>(
                        value: 'Khác',
                        groupValue: _selectedGender,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: phoneNumber,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Ngày sinh",
                  icon: Icon(Icons.date_range),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: schoolYear,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Niên khóa",
                  icon: Icon(Icons.time_to_leave),
                ),
              ),
              TextField(
                controller: imageURL,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Link avatar",
                  icon: Icon(Icons.image),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () {
                  
                },
                child:  Text("Chỉnh sửa"),
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), 
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
