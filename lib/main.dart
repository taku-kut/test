import 'package:flutter/material.dart';
import 'package:test_app/word_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListTest(),
    );
  }
}

class ListTest extends StatefulWidget {
  const ListTest({super.key});

  @override
  State<ListTest> createState() => _ListTestState();
}

class _ListTestState extends State<ListTest> {
  int ListNumber = 0;
  int total = 0;
  int displayListNumber = 0;
  final wordList = WordList();

  List<List<bool>> _checked =
      List.generate(28, (_) => List.generate(100, (_) => false));

  void setBandNumber(int inData) {
    setState(() {
      ListNumber = inData;
    });
    // print(ListNumber);
  }

  void _selectAll() {
    setState(() {
      _checked[ListNumber] =
          List<bool>.filled(_checked[ListNumber].length, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListViewテスト'),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Text(
                '英単語を選択する',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 8),
              Text(
                '学習したい英単語を追加してください',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 8),
              // ScrollHorizontalAppBar(),
              Container(
                color: Colors.blue,
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemExtent: 96,
                  itemCount: 28,
                  itemBuilder: (context, index) {
                    displayListNumber = index + 1;
                    return TextButton(
                      child: Text(
                        'リスト$displayListNumber',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        setBandNumber(index);
                      },
                    );
                  },
                ),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: 100,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3.5,
                  ),
                  itemBuilder: (context, index2) {
                    return Container(
                      color: Colors.white,
                      child: Container(
                        child: CheckboxListTile(
                          value: _checked[ListNumber][index2],
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (value) {
                            setState(() {
                              _checked[ListNumber][index2] = value!;
                            });
                          },
                          title: Text(wordList.getEnglish(index2, ListNumber)),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(160, 16),
                      backgroundColor: Color.fromARGB(255, 198, 255, 255),
                    ),
                    child: const Text(
                      'すべて選択',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    onPressed: () {
                      _selectAll();
                    },
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(160, 16),
                      backgroundColor: Color.fromARGB(255, 198, 255, 255),
                    ),
                    child: const Text(
                      '選択項目を追加',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
