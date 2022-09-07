import 'package:flutter/material.dart';

class ScreenControlled extends StatefulWidget {
  const ScreenControlled({Key? key}) : super(key: key);

  @override
  State<ScreenControlled> createState() => _ScreenConrolledState();
}

enum ButtonType { Start, Pause, End }

class _ScreenConrolledState extends State<ScreenControlled> {
  ButtonType pressed = ButtonType.End;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        ElevatedButton(
          onPressed: pressed != ButtonType.Start
              ? () {
                  setState(() => pressed = ButtonType.Start);
                }
              : null,
          child:
              const Padding(padding: EdgeInsets.all(10), child: Text("Start")),
          style: ElevatedButton.styleFrom(
              primary: Colors.green, textStyle: TextStyle(fontSize: 50)),
        ),
        SizedBox(height: 50),
        ElevatedButton(
            onPressed: pressed == ButtonType.Start
                ? () {
                    setState(() => pressed = ButtonType.Pause);
                  }
                : null,
            child: const Padding(
                padding: EdgeInsets.all(10),
                child: const Text("||", style: TextStyle(fontSize: 50)))),
        SizedBox(height: 50),
        ElevatedButton(
          onPressed: pressed != ButtonType.End
              ? () {
                  setState(() => pressed = ButtonType.End);
                }
              : null,
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
