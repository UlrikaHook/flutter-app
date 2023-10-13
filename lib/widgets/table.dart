import 'package:flutter/material.dart';

class TableView extends StatelessWidget {
  TableView({required this.headers, required this.data, Widget? footer, Key? key}) :
        this.footer = footer != null ? [footer] : null,
        super(key: key);

  final List<String> headers;
  final List<List<Widget>> data;
  final List<Widget>? footer;

  final TextStyle headerStyle = const TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 18.0, 0.0, 10.0),
                      child: Row(
                        children: headers.asMap().entries.map((entry) {
                          return Expanded(
                              child: Text(
                                  entry.value,
                                  style: headerStyle,
                                  textAlign: entry.key == 0 ? TextAlign.start : TextAlign.end
                              ),
                              flex: entry.key == 0 ? 2 : 1
                          );
                        }).toList()
                      ),
                    ),
                    Expanded(
                        child: ListView(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: data.map<Widget>((widgets) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
                                  child: Row(
                                      children: widgets
                                  ),
                                );
                              }).toList()
                        ),
                    )
                  ]
              ),
            ),
            ...?footer
          ],
        )
    );
  }
}
