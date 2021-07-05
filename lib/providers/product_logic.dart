import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:classifieds_app/data/data.dart';
import 'package:classifieds_app/models/product.dart';

class ProductLogic with ChangeNotifier {
  final String _domain = getUrl();

  List<Product> _products = [];

  List<Product> get products {
    return _products;
  }

  Future<List<Product>> getAllProducts() async {
    final uri = Uri.parse(_domain + '/public/products');

    try {
      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );
      print(response.body);

      if (response.statusCode == 200) {
        final products =
            jsonDecode(response.body)['products'].cast<Map<String, dynamic>>();
        _products =
            products.map<Product>((json) => Product.fromJson(json)).toList();

        _products.sort((a, b) => a.name!.compareTo(b.name!));

        notifyListeners();
        print(_products.length);
      }
      return _products;
    } catch (e) {
      print(e);

      return [];
    }
  }
}
