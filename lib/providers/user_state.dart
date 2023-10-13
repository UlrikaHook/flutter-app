import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/models/purchase.dart';

import 'cart_state.dart';

class UserState extends ChangeNotifier {
  List<Purchase> purchases = [];

  void addPurchase(List<CartItem> cartItems) {
    int bill = 0;
    for (CartItem item in cartItems) {
      bill += (item.price * item.amount);
    }

    purchases.add(Purchase(date: DateTime.now(), bill: bill, items: cartItems));
    notifyListeners();
  }
}