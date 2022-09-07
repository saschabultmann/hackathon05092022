import 'package:flutter/material.dart';

class AddPause extends StatelessWidget {
  const AddPause({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Draggable(
      feedback: AddPauseContent(),
      child: AddPauseContent(),
      data: [],
    );
  }
}

class AddPauseContent extends StatelessWidget {
  const AddPauseContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: Container(
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
        child: const Center(
          child: Icon(
            Icons.pause,
          ),
        ),
      ),
    );
  }
}
