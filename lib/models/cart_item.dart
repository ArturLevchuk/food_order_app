import 'package:food_order_app/models/product.dart';

class CartItem {
  final String cartId;
  final int count;
  final String productId;
  final Map<String, dynamic> additives;
  final Map<String, dynamic> size;

  CartItem({
    required this.cartId,
    required this.count,
    required this.productId,
    required this.additives,
    required this.size,
  });

  double get getPrice {
    double price = 0;
    price += size.values.first;
    additives.forEach((key, value) {
      price += value;
    });
    return price * count;
  }
}

final List<Map<String, dynamic>> cartItems = [
  {
    "cartId": "0",
    "count": "1",
    "productId": "1",
    "additives": {"Моццарелла 40г": 35, "Пармезан 20г": 30, "Чеддер 30г": 27},
    "size": {
      "30": 150,
    },
  },
  {
    "cartId": "1",
    "count": "1",
    "productId": "2",
    "additives": {"Моццарелла 40г": 35, "Пармезан 20г": 30, "Чеддер 30г": 27},
    "size": {
      "40": 190,
    },
  }
];
