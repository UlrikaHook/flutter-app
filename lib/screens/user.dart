import 'package:flutter/material.dart';
import 'package:flutter_demo/utility/build_item_summary.dart';
import 'package:provider/provider.dart';

import 'package:flutter_demo/widgets/top_bar.dart';
import 'package:flutter_demo/providers/user_state.dart';
import 'package:flutter_demo/widgets/table.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  bool isEditing = false;
  final _formKey = GlobalKey<FormState>();

  late FocusNode myFocusNode = FocusNode();

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserState>(
        builder: (context, user, child) {
          return Scaffold(
              appBar: TopBar('My page'),
              body: Column(
                children: [
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: TableView(
                        headers: ['My profile'],
                        data: [
                          [
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                focusNode: myFocusNode,
                                initialValue: 'Test Fluttersson',
                                readOnly: !isEditing,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Name',
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                onPressed: () {
                                  if(isEditing && _formKey.currentState!.validate()) {
                                    setState(() {
                                      isEditing = false;
                                      myFocusNode.unfocus();
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Profile updated')),
                                    );
                                  } else {
                                    setState(() => isEditing = true);
                                    myFocusNode.requestFocus();
                                  }
                                },
                                iconSize: 24.0,
                                color: Colors.blue,
                                icon: isEditing ? const Icon(Icons.done) : const Icon(Icons.edit),
                                splashRadius: 20.0,
                              ),
                            )
                          ]
                        ]
                      )
                    ),
                  ),
                  Expanded(
                    child: TableView(
                      headers: ['Purchases'],
                      data: user.purchases.map((purchase) {
                        return <Widget>[
                          Expanded(
                            child: ExpansionTile(
                              title: Text(
                                  '${purchase.date.year}-${purchase.date.month}-${purchase
                                      .date.day} '
                                      '${purchase.date.hour}:${purchase.date.minute}'
                              ),
                              subtitle:  Text('${purchase.bill} SEK'),
                              children: purchase.items.map<Widget>((item) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(children: buildItemSummary(item)),
                              )).toList() ,
                            ),
                          ),
                        ];
                      }).toList(),
                    ),
                  )
                ]
              )
          );
      });
  }
}
