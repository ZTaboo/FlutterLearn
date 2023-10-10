import 'package:flutter/material.dart';
import 'package:z_ping/top_input.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  // 声明list
  var list = [];

  void onUpdate(String con) {
    setState(() {
      list.insert(0, con);
    });
  }

  void cleanList() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ping',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ping'),
          backgroundColor: Colors.black,
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 2),
                  child: TopInput(
                    onUpdate: onUpdate,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 230,
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Scrollbar(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Text('${list[index]}\n');
                        },
                        itemCount: list.length,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.only(bottom: 16),
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                list.clear();
              });
            },
            child: const Icon(Icons.delete_forever),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }
}
