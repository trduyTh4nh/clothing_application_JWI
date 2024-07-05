import 'package:flutter/material.dart';
import 'package:tuan08/app/page/auth/login.dart';
import 'dart:convert';

class AppRoute {
  static Route onGenerateRoute(RouteSettings route) {
    switch (route.name) {
      // case "/":
      //     return MaterialPageRoute(builder: (_) => const SplashScreen()); //-> tao 1 screen
      case "Login":
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }

  static void pushScreen(BuildContext context, Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}

class CategoryModel {
  final int? id;
  final String name;
  final String desc;
  String? imageURL;

  CategoryModel(
      {this.id, required this.name, required this.desc, this.imageURL});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'desc': desc, 'imageURL': imageURL};
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
        id: map['id']?.toInt() ?? 0,
        name: map['name'] ?? '',
        desc: map['desc'] ?? '',
        imageURL: map['imageURL'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));

  // Implement toString to make it easier to see information about
  // each breed when using the print statement.
  @override
  String toString() =>
      'Category(id: $id, name: $name, desc: $desc, imageURL: $imageURL)';
}
