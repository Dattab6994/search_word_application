import 'package:flutter/material.dart';
import 'package:search_word_application/view/word_search_page.dart';

class GridViewPage extends StatefulWidget {
  final int row;
  final int column;

  const GridViewPage({super.key, required this.column, required this.row});

  @override
  State<GridViewPage> createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  late int r, c;
  late var gridList;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    r = widget.row;
    c = widget.column;
    gridList = List.generate(r, (i) => List.filled(c, "", growable: false),
        growable: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grid View Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: GridView.count(
                  crossAxisCount: r,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 20,
                  children: List.generate(
                    r * c,
                    (index) {
                      return Center(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "";
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          textAlign: TextAlign.center,
                          initialValue:
                              gridList[index - ((index / r).floor() * r)]
                                  [(index / r).floor()],
                          onChanged: (value) {
                            gridList[index - ((index / r).floor() * r)]
                                [(index / r).floor()] = value;
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => WordSearchPage(
                            gridList: gridList,
                            row: r,
                            column: c,
                          ))));
            }
          },
          child: const Text(
            "View Grid",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}