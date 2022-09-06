import 'package:flutter/material.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        ElevatedButton(
          onPressed: null,
          child: const Text("Start"),
          style: ElevatedButton.styleFrom(primary: Colors.green),
        ),
        ElevatedButton(onPressed: null, child: const Text("||")),
        ElevatedButton(
          onPressed: null,
          child: const Text("Stop"),
          style: ElevatedButton.styleFrom(primary: Colors.red),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    ));
  }
}
