import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/page_bloc.dart';
import '../utils/screen.dart';

class ScreenAutomatic extends StatefulWidget {
  const ScreenAutomatic({Key? key}) : super(key: key);

  @override
  State<ScreenAutomatic> createState() => _ScreenAutomaticState();
}

enum Mode { Idle, Collecting }

class _ScreenAutomaticState extends State<ScreenAutomatic> {
  Mode mode = Mode.Idle;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        mode == Mode.Idle
            ? SizedBox(height: 50)
            : SizedBox(
                height: 50, width: 50, child: CircularProgressIndicator()),
        mode == Mode.Idle
            ? SizedBox(height: 50)
            : SizedBox(
                height: 50,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text("Daten werden aufgezeichnet...",
                        style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (mode == Mode.Idle) {
                mode = Mode.Collecting;
              } else {
                mode = Mode.Idle;
                BlocProvider.of<PageBloc>(context)
                    .add(PageChange(Screen.Login));
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    _timer = Timer(Duration(seconds: 2), () {
                      Navigator.of(context).pop();
                    });
                    return AlertDialog(
                      title: Text("Erfolgreich"),
                      content: Text("Deine Buchung ist abgeschlossen."),
                    );
                  },
                ).then((val) {
                  if (_timer != null && _timer!.isActive) {
                    _timer!.cancel();
                  }
                });
              }
            });
          },
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(mode == Mode.Idle ? "Start" : "Stop")),
          style: ElevatedButton.styleFrom(
              primary: mode == Mode.Idle ? Colors.green : Colors.red,
              textStyle: TextStyle(fontSize: 50)),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    ));
  }
}
