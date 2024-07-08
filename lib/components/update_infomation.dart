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
        title: Text("Chỉnh sửa thông tin cá nhân"),
      ),
      body: SingleChildScrollView(
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
                icon: Icon(Icons.numbers_outlined),
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
                icon: Icon(Icons.abc),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              children: <Widget>[
                ListTile(
                  title: const Text('Male'),
                  leading: Radio<String>(
                    value: 'Male',
                    groupValue: _selectedGender,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Female'),
                  leading: Radio<String>(
                    value: 'Female',
                    groupValue: _selectedGender,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Other'),
                  leading: Radio<String>(
                    value: 'Other',
                    groupValue: _selectedGender,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            
          ],
        ),
      ),
    );
  }
}
