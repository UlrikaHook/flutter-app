import 'package:flutter/material.dart';

import '../models/action.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = Size.fromHeight(50.0);

  final String title;
  final List<TopBarAction>? actions;

  TopBar(this.title, { this.actions, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        Row(
            children: actions?.map<Widget>((action) {
              return Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, action.route),
                    child: action.icon,
                  )
              );
            }).toList() ?? []
        )
      ]
    );
  }
}

