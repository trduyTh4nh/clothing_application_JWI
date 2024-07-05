import 'package:flutter/material.dart';
import 'package:tuan08/app/page/product_management.dart';
import 'package:tuan08/components/management.dart';

class Adminpage extends StatefulWidget {
  const Adminpage({super.key});

  @override
  State<Adminpage> createState() => _AdminpageState();
}

class _AdminpageState extends State<Adminpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Page"),
      ),
      body: Column(children: [
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ManagementPage(),
                          ),
                        );
                      },
                      child: const Text("CRUD"),
                    ),
      ],),
    );
  }
}