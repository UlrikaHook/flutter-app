import 'package:flutter/material.dart';
import 'package:flutter_demo/utility/build_item_summary.dart';
import 'package:flutter_demo/widgets/table.dart';
import 'package:provider/provider.dart';

import 'package:flutter_demo/widgets/top_bar.dart';
import 'package:flutter_demo/providers/cart_state.dart';
import 'package:flutter_demo/providers/user_state.dart';


class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  final TextStyle headerStyle = const TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar('Cart'),
      body: Consumer<CartState>(
          builder: (context, cart, child) {
            if (cart.cartItems.length == 0) {
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Your cart is empty', style: headerStyle),
                      TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blue
                          ),
                          onPressed: () => Navigator.pushNamed(context, '/'),
                          child: const Text(
                              'Start shopping!',
                              style: TextStyle(
                                  color: Colors.white
                              )
                          )
                      )
                    ],
                  )
              );
            }
            return TableView(
              headers: ['Product', 'Amount', 'Price'],
              data: cart.cartItems.map(buildItemSummary).toList(),
              footer: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blue
                  ),
                  onPressed: () {
                    Provider.of<UserState>(context, listen: false).addPurchase(cart.cartItems);
                    cart.emptyCart();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Thank you for your purchase')),
                    );
                  },
                  child: const Text(
                      'Buy',
                      style: TextStyle(
                          color: Colors.white
                      )
                  )
              )
            );
          }
        )
    );
  }
}

