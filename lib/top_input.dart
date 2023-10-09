import 'dart:convert';

import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/material.dart';

class TopInput extends StatefulWidget {
  const TopInput({required this.onUpdate, super.key});

  final ValueChanged<String> onUpdate;
  @override
  State<TopInput> createState() => _TopInput();
}

class _TopInput extends State<TopInput> {
  var textInput = TextEditingController();
  var runState = false;

  void setPing(bool state) {
    setState(() {
      runState = !runState;
    });
    final ping =
        Ping(textInput.text, encoding: const Utf8Codec(allowMalformed: true));
    ping.stream.listen((event) {
      if (!runState) {
        ping.stop();
        return;
      }
      var eventJson = jsonDecode(event.toJson());
      if (eventJson['response'].toString() != 'null') {
        var time = "";
        if (eventJson["response"]["time"] == null) {
          time = "null";
        } else {
          time = "${eventJson["response"]["time"]}ms";
        }
        widget.onUpdate(
            'ttl:${eventJson["response"]["ttl"]} time:$time  ip:${eventJson["response"]["ip"]}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'IP地址:',
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(left: 20),
          child: TextField(
            decoration: const InputDecoration(
                hintText: '请输入IP地址', hintStyle: TextStyle(fontSize: 13)),
            controller: textInput,
          ),
        )),
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: runState
              ? ElevatedButton(
                  onPressed: () {
                    setPing(false);
                  },
                  child: const Text("Stop"))
              : ElevatedButton(
                  onPressed: () {
                    setPing(true);
                  },
                  child: const Text("Run")),
        )
      ],
    );
  }
}
