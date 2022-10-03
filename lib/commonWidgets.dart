import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Future sendPackets(String effect, Color pickedColor) async {
  print(pickedColor);
  final response = await http.post(
    Uri.http('192.168.0.151:8082', '/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'effect': effect,
      'red': pickedColor.red,
      'green': pickedColor.green,
      'blue': pickedColor.blue
    }),
  );
}

class PatternList extends StatefulWidget {
  final List<String> patterns;
  const PatternList({super.key, required this.patterns});

  @override
  State<StatefulWidget> createState() => _PatternListState();
}

class _PatternListState extends State<PatternList> {
  late List<String> leftPatterns;
  late List<String> rightPatterns;

  @override
  void initState() {
    super.initState();
    leftPatterns = widget.patterns.sublist(widget.patterns.length ~/ 2);
    rightPatterns = widget.patterns.sublist(0, widget.patterns.length ~/ 2);
  }

  Color pickedColor = Colors.lightBlue;

  @override
  Widget build(BuildContext context) {
    return
      Column(children: [
        SizedBox(
      height: 300,
      child:
      Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Column(children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: leftPatterns.length,
                        itemBuilder: (context, index) {
                          return Column(children: [
                            const SizedBox(height: 10),
                            SizedBox(
                                height: 50,
                                width: 100,
                                child: ElevatedButton(
                                    child: Text(leftPatterns[index]),
                                    onPressed: () {
                                      setState(() {
                                        sendPackets(
                                            leftPatterns[index], pickedColor);
                                      });
                                    })),
                          ]);
                        }))
              ])),
          Expanded(
              child: ListView.builder(
                  itemCount: rightPatterns.length,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      const SizedBox(height: 10),
                      SizedBox(
                          height: 50,
                          width: 100,
                          child: ElevatedButton(
                              child: Text(rightPatterns[index]),
                              onPressed: () {
                                setState(() {
                                  sendPackets(
                                      rightPatterns[index], pickedColor);
                                });
                              })),
                    ]);
                  })),
        ],
      )),
      SizedBox(
        height: 300,
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          titlePadding: const EdgeInsets.all(0),
                          contentPadding: const EdgeInsets.all(0),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: pickedColor,
                              onColorChanged: (Color color) {
                                setState(() {
                                  pickedColor = color;
                                });
                              },
                            ),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('DONE'),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); //dismiss the color picker
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: pickedColor,
                    shadowColor: pickedColor.withOpacity(1),
                    elevation: 10,
                  ),
                  child: Text(
                    'Choose color here',
                    style: TextStyle(
                        color: useWhiteForeground(pickedColor)
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    ]);
  }
}
