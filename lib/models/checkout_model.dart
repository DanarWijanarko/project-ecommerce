import 'package:cloud_firestore/cloud_firestore.dart';

class Checkout {
  String id;
  final String cusId;
  final String cusName;
  final String cusAddress;
  final String cusPhone;
  final List<Map<String, dynamic>> products;
  final Timestamp timestamp;
  final String totalPrice;
  final String status;

  Checkout({
    this.id = '',
    required this.cusId,
    required this.cusName,
    required this.cusAddress,
    required this.cusPhone,
    required this.products,
    required this.timestamp,
    required this.totalPrice,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'cusId': cusId,
        'cusName': cusName,
        'cusAddress': cusAddress,
        'cusPhone': cusPhone,
        'products': products,
        'timestamp': timestamp,
        'totalPrice': totalPrice,
        'status': status,
      };

  static Checkout fromJson(Map<String, dynamic> json) => Checkout(
        id: json['id'],
        cusId: json['cusId'],
        cusName: json['cusName'],
        cusAddress: json['cusAddress'],
        cusPhone: json['cusPhone'],
        products: List<Map<String, dynamic>>.from(json['products']),
        timestamp: json['timestamp'],
        totalPrice: json['totalPrice'],
        status: json['status'],
      );
}
