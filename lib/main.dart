import 'package:flutter/material.dart';
import 'package:flutter_demo/providers/user_state.dart';
import 'package:flutter_demo/screens/user.dart';
import 'package:flutter_demo/screens/cart.dart';
import 'package:flutter_demo/screens/shop.dart';
import 'package:provider/provider.dart';

import 'providers/cart_state.dart';

void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CartState()),
            ChangeNotifierProvider(create: (context) => UserState()),
          ],
        child: MaterialApp(
          home: Shop(),
          routes: {
            '/cart': (context) => const Cart(),
            '/user': (context) => const User()
          },
        )
      )
  );
}

