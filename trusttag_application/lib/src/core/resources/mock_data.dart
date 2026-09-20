import 'package:flutter/material.dart';

class Product {
  final String name;
  final String model;
  final String status;
  final Color statusColor;
  final String condition;
  final String owner;
  final String assetPath;

  Product({
    required this.name,
    required this.model,
    required this.status,
    required this.statusColor,
    required this.condition,
    required this.owner,
    required this.assetPath,
  });
}

class MockData {
  static final List<Product> products = [
    Product(
      name: 'Iphone 15 Pro',
      model: 'Apple . M301',
      status: 'Verified',
      statusColor: Colors.green,
      condition: 'Excellent',
      owner: 'Aaryan Bharvadiya',
      assetPath: 'assets/images/iphone15.png',
    ),
    Product(
      name: 'Dell Latitude 7490',
      model: 'Dell . M302',
      status: 'Verified',
      statusColor: Colors.green,
      condition: 'Excellent',
      owner: 'Aaryan Bharvadiya',
      assetPath: 'assets/images/laptop.png',
    ),
    Product(
      name: 'Samsung Galaxy S24',
      model: 'Samsung . S24',
      status: 'Pending',
      statusColor: Colors.amber,
      condition: 'Excellent',
      owner: 'Aaryan Bharvadiya',
      assetPath: 'assets/images/iphone15.png',
    ),
  ];
}
