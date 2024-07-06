import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tuan08/app/model/category.dart';
import 'package:tuan08/app/model/product.dart';
import 'package:tuan08/app/model/register.dart';
import 'package:tuan08/app/model/user.dart';

class API {
  final Dio _dio = Dio();
  String baseUrl = "https://huflit.id.vn:4321";

  API() {
    _dio.options.baseUrl = "$baseUrl/api";
  }

  Dio get sendRequest => _dio;
}

class APIRepository {
  API api = API();

  Map<String, dynamic> header(String token) {
    return {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };
  }

  Future<String> register(Signup user) async {
    try {
      final body = FormData.fromMap({
        "numberID": user.numberID,
        "accountID": user.accountID,
        "fullName": user.fullName,
        "phoneNumber": user.phoneNumber,
        "imageURL": user.imageUrl,
        "birthDay": user.birthDay,
        "gender": user.gender,
        "schoolYear": user.schoolYear,
        "schoolKey": user.schoolKey,
        "password": user.password,
        "confirmPassword": user.confirmPassword
      });
      Response res = await api.sendRequest.post('/Student/signUp',
          options: Options(headers: header('no token')), data: body);
      if (res.statusCode == 200) {
        print("ok");
        return "ok";
      } else {
        print("fail");
        return "signup fail";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<String> login(String accountID, String password) async {
    try {
      final body =
          FormData.fromMap({'AccountID': accountID, 'Password': password});
      Response res = await api.sendRequest.post('/Auth/login',
          options: Options(headers: header('no token')), data: body);
      if (res.statusCode == 200) {
        final tokenData = res.data['data']['token'];
        print("ok login");
        
        return tokenData;
      } else {
        return "login fail";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<String> forgetPassword(
      String accountID, String numberID, String newPass, String token) async {
    try {
      final body = FormData.fromMap(
          {'accountID': accountID, 'numberID': numberID, 'newPass': newPass});
      Response res = await api.sendRequest.put('/Auth/forgetPass',
          options: Options(headers: header(token)), data: body);

      if (res.statusCode == 200) {
        return "Change success";
      } else {
        return "Fail";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<User> current(String token) async {
    try {
      Response res = await api.sendRequest
          .get('/Auth/current', options: Options(headers: header(token)));
      return User.fromJson(res.data);
    } catch (ex) {
      rethrow;
    }
  }

  /// Product
  Future<List<ProductModel>> getListProduct(
      String accountID, String token) async {
    try {
      Response res = await api.sendRequest.get('/Product/getList',
          options: Options(headers: header(token)),
          queryParameters: {"accountID": accountID});

      var data = res.data;

      List<ProductModel> listProduct = [];
      for (var element in data) {
        listProduct.add(ProductModel.fromJson(element));
      }
      print(listProduct);
      return listProduct;
    } catch (ex) {
      rethrow;
    }
  }

  Future<void> addProduct(String token, String name, String description,
      String imageURL, double price, int categoryId) async {
    try {
      final body = FormData.fromMap({
        'Name': name,
        'Description': description,
        'ImageURL': imageURL,
        'Price': price,
        'CategoryID': categoryId
      });
      Response res = await api.sendRequest.post('/addProduct',
          options: Options(
            headers: header(token),
          ),
          data: body);

      if (res.statusCode == 200) {
        final data = res.data;
        print(data);
        print("Add product success");
      } else {
        print("Add product fail!");
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<void> deleteProduct(
      String token, String accountID, int productId) async {
    try {
      final body =
          FormData.fromMap({'productID': productId, 'accountID': accountID});

      Response res = await api.sendRequest.delete('/removeProduct',
          options: Options(headers: header(token)), data: body);

      if (res.statusCode == 200) {
        final data = res.data;
        print(data);
        print("Remove product success");
      } else {
        print("Remove product fail!");
      }
    } catch (eror) {
      print(eror);
      rethrow;
    }
  }

  Future<int?> updateProduct(
      String accountID,
      int idProduct,
      String name,
      String description,
      String imageURL,
      double price,
      String categoryID,
      String token) async {
    try {
      final body = FormData.fromMap({
        'id': idProduct,
        'Name': name,
        'Description': description,
        'ImageURL': imageURL,
        'Price': price,
        'CategoryID': categoryID,
        'accountID': accountID
      });

      Response res = await api.sendRequest.put('/updateProduct',
          options: Options(
            headers: header(token),
          ),
          data: body);

      if (res.statusCode == 200) {
        print('Update product success');
        return res.statusCode;
      } else {
        print('Update product fail');
        return res.statusCode;
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  // category

  Future<List<CategoryModel>> getListCategory(
      String accountID, String token) async {
    try {
      Response res = await api.sendRequest.get('/Category/getList',
          options: Options(
            headers: header(token),
          ),
          queryParameters: {"accountID": accountID});
      var data = res.data;
      List<CategoryModel> lst = [];
      for (var element in data) {
        lst.add(CategoryModel.fromJson(jsonEncode(element)));
      }
      return lst;
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> adCategory(String name, String description, String imageUrl,
      String accountID, String token) async {
    try {
      final body = FormData.fromMap({
        'Name': name,
        'Description': description,
        'ImageURL': imageUrl,
        'AccountID': accountID
      });
      Response res = await api.sendRequest.post('/addCategory',
          options: Options(headers: header(token)), data: body);

      if (res.statusCode == 200) {
        print("Add category successfully!");
        return "ok";
      } else {
        print("Add category fail!");
        return "fail";
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<String> removeCategory(
      int categoryID, String accountID, String token) async {
    try {
      final body =
          FormData.fromMap({'categoryID': categoryID, 'accountID': accountID});

      Response response = await api.sendRequest.delete('/removeCategory',
          options: Options(headers: header(token)), data: body);

      if (response.statusCode == 200) {
        print("Delete successfully!");
        return "ok";
      } else {
        print("Delete fail!");
        return "fail";
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }


  Future<String> updateCategory(
      String accountID,
      int id,
      String name,
      String description,
      String imageURL,
      String token) async {
    try {
      print(description);
      final body = FormData.fromMap({
        'id': id,
        'Name': name,
        'Description': description,
        'ImageURL': imageURL,
        'AccountID': accountID
      });

      Response res = await api.sendRequest.put('/updateCategory',
          options: Options(
            headers: header(token),
          ),
          data: body);

      if (res.statusCode == 200) {
        print('Update category successfully!');
        return "ok";
      } else {
        print('Update category fail');
        return "fail";
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
