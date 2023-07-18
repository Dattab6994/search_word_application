import 'package:flutter/material.dart';
import 'package:search_word_application/view/grid_view_page.dart';
import 'create_grid_page.dart';

class WordSearchPage extends StatefulWidget {
  int row;
  int column;
  var gridList;

  WordSearchPage(
      {super.key,
      required this.row,
      required this.column,
      required this.gridList});

  @override
  State<WordSearchPage> createState() => _WordSearchPageState();
}

class _WordSearchPageState extends State<WordSearchPage> {
  late String word;
  late List list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Word"),
      ),
      body: Container(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: GridView.count(
                crossAxisCount: widget.row,
                crossAxisSpacing: 0.2,
                mainAxisSpacing: 10,
                children: List.generate(
                  widget.row * widget.column,
                  (value) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.0),
                            color: list.contains(value)
                                ? Colors.red
                                : Colors.brown),
                        child: Text(
                          widget.gridList[value -
                                  ((value / widget.row).floor() * widget.row)]
                              [(value / widget.row).floor()],
                          style: TextStyle(
                              fontSize: 20.0,
                              color: list.contains(value)
                                  ? Colors.black
                                  : Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20.0),
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.all(12),
                      hintText: "Search Word",
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2.0, color: Colors.blue),
                          borderRadius: BorderRadius.circular(5)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onChanged: (value) {
                    word = value;
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            list = wordSearch(widget.gridList, word, widget.row,
                                widget.column);
                          });
                        },
                        child: const Text(
                          "Search",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => GridViewPage(
                                        column: widget.column,
                                        row: widget.row))));
                          },
                          child: const Text("Change",
                              style: TextStyle(fontSize: 16.0))),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const CreateGridPage())));
                          },
                          child: const Text("Reset",
                              style: TextStyle(fontSize: 16.0))),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //ignore: non_constant_identifier_names
  wordSearch(List twoDList, String word, int r, int c) {
    List index = [];
    int flag = 0;

    int wordLength = word.length;
    for (int i = 0; i < r; i++) {
      for (int j = 0; j < c; j++) {
        if (twoDList[i][j] == word[0]) {
          if (r - wordLength >= i) {
            int inc = 0;
            int k;
            for (k = i; k < i + wordLength; k++) {
              if (twoDList[k][j] == word[inc]) {
                flag = 1;
                inc++;
              } else {
                flag = 0;
                break;
              }
            }
            if (flag == 1) {
              for (int l = i; l < k; l++) {
                index.add((j * r) + l);
              }
            }
          }
          if (c - wordLength >= j) {
            int inc = 0;
            int k;
            for (k = j; k < j + wordLength; k++) {
              if (twoDList[i][k] == word[inc]) {
                flag = 1;
                inc++;
              } else {
                flag = 0;
                break;
              }
            }
            if (flag == 1) {
              for (int l = j; l < k; l++) {
                index.add((l * r) + i);
              }
            }
          }

          if (c - wordLength >= j && r - wordLength >= i) {
            int inc = 0;
            int k;
            int m = i;
            for (k = j; k < j + wordLength && m < i + wordLength; k++) {
              if (twoDList[m][k] == word[inc]) {
                flag = 1;
                inc++;
              } else {
                flag = 0;
                break;
              }
              m++;
            }
            if (flag == 1) {
              int cnt = 0;
              for (int l = j; l < k; l++) {
                index.add(((l * r) + i) + cnt);
                cnt++;
              }
            }
          }
        }
      }
    }

    return index;
  }
}
