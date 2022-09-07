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
          onPressed: () {},
          child:
              const Padding(padding: EdgeInsets.all(10), child: Text("Start")),
          style: ElevatedButton.styleFrom(
              primary: Colors.green, textStyle: TextStyle(fontSize: 50)),
        ),
        SizedBox(height: 50),
        ElevatedButton(
            onPressed: () {},
            child: const Padding(
                padding: EdgeInsets.all(10),
                child: const Text("||", style: TextStyle(fontSize: 50)))),
        SizedBox(height: 50),
        ElevatedButton(
          onPressed: () {},
          child:
              const Padding(padding: EdgeInsets.all(10), child: Text("Stop")),
          style: ElevatedButton.styleFrom(
              primary: Colors.red, textStyle: TextStyle(fontSize: 50)),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    ));
  }
}
