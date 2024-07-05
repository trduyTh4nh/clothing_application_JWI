import 'package:flutter/material.dart';

class DefaultWidget extends StatelessWidget {
  const DefaultWidget({super.key, required this.title});
  final String title;
  // khi dùng tham số truyền vào phải khai báo biến trùng tên require
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
