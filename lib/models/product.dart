import 'dart:io';

class Product {
  String? id;
  String? name;
  double? price;
  String? description;
  String? imageUrl;
  File? image;
  String? category;
  DateTime? manufactureDate;
  DateTime? createdAt;

  Product({
    this.id,
    this.category,
    this.description,
    this.image,
    this.imageUrl,
    this.manufactureDate,
    this.name,
    this.price,
    this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      imageUrl: json['image'],
      manufactureDate: DateTime.parse(json['date']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
