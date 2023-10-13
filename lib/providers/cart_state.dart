import 'package:flutter/material.dart';
import 'package:flutter_demo/models/item.dart';

class CartState extends ChangeNotifier {
  List<CartItem> cartItems = [];

  void addToCart(Item item) {
    CartItem itemInCart = cartItems.firstWhere(
        (cartItem) => cartItem.color == item.color,
        orElse: () {
          CartItem newItem = CartItem(0, item);
          cartItems.add(newItem);
          return newItem;
        }
    );

    itemInCart.amount++;
    notifyListeners();
  }

  void removeFromCart(Item item) {
    int index = cartItems.indexWhere((cartItem) => cartItem.color == item.color);

    if (index == -1) return;

    if (cartItems[index].amount <= 1) {
      cartItems.removeAt(index);
    } else {
      cartItems[index].amount--;
    }

    notifyListeners();
  }

  void emptyCart() {
    cartItems = [];
    notifyListeners();
  }

  int getItemAmount(Item item) {
    int index = cartItems.indexWhere((cartItem) => cartItem.color == item.color);

    if (index == -1) return 0;

    return cartItems[index].amount;
  }
}

class CartItem extends Item {
    int amount;

    CartItem(this.amount, Item item) : super(item.color, item.price, item.name) {}
}