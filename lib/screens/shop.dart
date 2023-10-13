import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_demo/models/action.dart';
import 'package:flutter_demo/models/item.dart';
import 'package:flutter_demo/widgets/top_bar.dart';
import 'package:flutter_demo/providers/cart_state.dart';

class Shop extends StatelessWidget {
  Shop({Key? key}) : super(key: key);

  final List<Item>items = [
    Item(Colors.green, 100, 'Green'),
    Item(Colors.yellow, 150, 'Yellow'),
    Item(Colors.orange, 50, 'Orange'),
    Item(Colors.red, 200, 'Red'),
    Item(Colors.pink, 10, 'Pink'),
    Item(Colors.purple, 350, 'Purple'),
    Item(Colors.blue, 400, 'Blue'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
       'Shop',
        actions: [
          TopBarAction(
              icon: const Icon(Icons.account_circle, size: 26.0,),
              route: '/user'
          ),
          TopBarAction(
              icon: const Icon(Icons.shopping_cart, size: 26.0,),
              route: '/cart'
          )
        ]
      ),
      body: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: items.map((item) => ItemBox(item)).toList(),
          )
      ),
    );
  }
}


class ItemBox extends StatelessWidget {
  final Item item;

  const ItemBox(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<CartState>(
        builder: (context, cart, child) {

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: item.color,
                          ),
                          width: 55.0,
                          height: 55.0,
                        ),
                        SizedBox(width: 10.0, height: 10.0),
                        Text('${item.name}')
                      ],
                    ),
                  ),
                  Expanded(flex: 1, child: Text('${item.price.toString()} SEK')),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 35.0,
                          height: 35.0,
                          child: Ink(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(25.0)),
                              color: Colors.blue,
                            ),
                            child: IconButton(
                              onPressed: cart.getItemAmount(item) == 0 ? null : () => cart.removeFromCart(item),
                              iconSize: 20.0,
                              color: Colors.white,
                              icon: const Icon(Icons.remove),
                              splashRadius: 20.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0, height: 10.0),
                        Text('${cart.getItemAmount(item)}'),
                        SizedBox(width: 10.0, height: 10.0),
                        SizedBox(
                          width: 35.0,
                          height: 35.0,
                          child: Ink(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(25.0)),
                              color: Colors.blue,
                            ),
                            child: IconButton(
                              onPressed: () => cart.addToCart(item),
                              iconSize: 20.0,
                              color: Colors.white,
                              icon: const Icon(Icons.add),
                              splashRadius: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ]
            ),
          );
        }
    );
  }
}

