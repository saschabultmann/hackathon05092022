import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class Timeline extends StatelessWidget {
  const Timeline({Key? key, required this.from, required this.to})
      : super(key: key);

  final int from;
  final int to;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            children: List.generate(to - from + 1, (i) => i + from)
                .map((e) => TimeWidget(value: "${e <= 9 ? "0$e" : e}:00"))
                .toList()));
  }
}

class TimeWidget extends StatelessWidget {
  const TimeWidget({Key? key, required this.value}) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 60.0),
      child: Row(
        children: [
          Text(value, style: const TextStyle(color: Colors.grey)),
          Expanded(
            child: Container(
              child: const DottedLine(dashColor: Colors.grey),
              margin: const EdgeInsets.only(left: 5.0),
            ),
          ),
        ],
      ),
    );
  }
}
