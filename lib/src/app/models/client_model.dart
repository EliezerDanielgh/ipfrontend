import 'dart:convert';

// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

class Client {
  String? code;
  String? businessName;
  String? description;
  List<Map<String, dynamic>>? orders;

  Client({this.code, this.businessName, this.description, this.orders});

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'business_name': businessName,
      'description': description,
      'orders': orders
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      code: map['code'],
      businessName: map['business_name'],
      description: map['description'],
      orders: map['orders'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Client.fromJson(String source) => Client.fromMap(json.decode(source));
}
