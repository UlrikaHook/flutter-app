import 'package:flutter/material.dart';
import 'package:flutter_demo/providers/cart_state.dart';

List<Widget> buildItemSummary(CartItem item) {
    return <Widget>[
      Expanded(
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: item.color,
              ),
              width: 25.0,
              height: 25.0,
            ),
            SizedBox(width: 10.0, height: 10.0,),
            Text(item.name)
          ],
        ),
        flex: 2,
      ),
      Expanded(child: Text('${item.amount} st', textAlign: TextAlign.end,), flex: 1),
      Expanded(child: Text('${item.amount * item.price} SEK', textAlign: TextAlign.end), flex: 1),
    ];
}
