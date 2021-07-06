import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:classifieds_app/models/server_response.dart';
import 'package:classifieds_app/services/get_storage_data.dart';
import 'package:classifieds_app/data/data.dart';
import 'package:classifieds_app/models/product.dart';

class ProductLogic with ChangeNotifier {
  final String _domain = getUrl();

  List<Product> _products = [];
  List<Product> _myProducts = [];
  List<String> _categories = [];

  List<Product> get products {
    return [..._products];
  }

  List<Product> get myProducts {
    return [..._myProducts];
  }

  List<String> get categories {
    return [..._categories];
  }

  Future<void> getAllProducts() async {
    final uri = Uri.parse(_domain + '/public/products');

    try {
      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      final serverResponse = ServerResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
      if (!serverResponse.status!) return;

      final products =
          jsonDecode(response.body)['products'].cast<Map<String, dynamic>>();
      _products =
          products.map<Product>((json) => Product.fromJson(json)).toList();

      _products.sort((a, b) => a.name!.compareTo(b.name!));

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getMyProducts() async {
    final token = await getToken();
    final uri = Uri.parse(_domain + '/seller/products');

    try {
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token!,
        },
      );

      final serverResponse = ServerResponse.fromJson(jsonDecode(response.body));
      if (!serverResponse.status!) return;

      final data =
          jsonDecode(response.body)['products'].cast<Map<String, dynamic>>();
      _myProducts =
          data.map<Product>((json) => Product.fromJson(json)).toList();

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getProdsuctCategories() async {
    final uri = Uri.parse(_domain + '/public/categories');

    try {
      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      final serverResponse = ServerResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
      if (!serverResponse.status!) return;

      final categories = jsonDecode(response.body)['categories'].cast<String>();
      _categories = categories.map<String>((json) => json.toString()).toList();

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<ServerResponse> createProduct(Product product) async {
    final uri = _domain + '/seller/products';
    final token = await getToken();

    try {
      FormData formData = FormData.fromMap(
        {
          'name': product.name,
          'description': product.description,
          'category': product.category,
          'price': product.price,
          'date': product.manufactureDate,
          'image': await MultipartFile.fromFile(product.image!.path),
        },
      );

      final response = await Dio().post(
        uri,
        data: formData,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {'Authorization': token},
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      final serverResponse = ServerResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      if (response.statusCode == 422) {
        serverResponse.message = serverResponse.message! + '\n';
        serverResponse.errors!.forEach((element) {
          serverResponse.message = serverResponse.message! + '${element.msg}\n';
        });
      }

      if (serverResponse.status!) {
        final product = Product.fromJson(
          response.data['product'] as Map<String, dynamic>,
        );
        _products.add(product);
        _myProducts.add(product);

        _products.sort((a, b) => a.name!.compareTo(b.name!));

        notifyListeners();
      }

      return serverResponse;
    } on DioError catch (e) {
      print(e);

      return ServerResponse(
        status: false,
        message: 'Soemthing went wrong. Please try again later',
      );
    }
  }
}
