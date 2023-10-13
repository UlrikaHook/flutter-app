import 'package:flutter_demo/providers/cart_state.dart';

class Purchase {
  DateTime date;
  int bill;
  List<CartItem> items;

  Purchase({required this.date, required this.bill, required this.items}) {}
}