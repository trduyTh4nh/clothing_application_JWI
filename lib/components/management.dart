import 'package:flutter/material.dart';
import 'package:tuan08/app/page/category_management.dart';
import 'package:tuan08/app/page/product_management.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({super.key});

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý"),
      ),
      body: Column(
        children: [
          OutlinedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8), // Set the border radius to zero
                ),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductManagement(),
                ),
              );
            },
            child: const Text("Quản lý sản phẩm"),
          ),
          OutlinedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8), // Set the border radius to zero
                ),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategoryManagement(),
                ),
              );
            },
            child: const Text("Quản lý loại sản phẩm"),
          ),
        ],
      ),
    );
  }
}