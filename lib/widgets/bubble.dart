import 'package:flutter/material.dart';

import '../utils/project.dart';

typedef void OnBubbleTap(int projectId);

class Bubble extends StatelessWidget {
  const Bubble(
      {Key? key,
      required this.selectionIndex,
      required this.project,
      required this.onBubbleTap})
      : super(key: key);

  final int selectionIndex;
  final Project project;
  final OnBubbleTap onBubbleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onBubbleTap(project.id);
        },
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                  ),
                  color: selectionIndex >= 0 ? Colors.blue : Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Text(
                project.name,
                style: TextStyle(
                    fontSize: 15,
                    color: selectionIndex >= 0 ? Colors.white : Colors.blue),
              ),
            ),
            (selectionIndex >= 0
                ? Positioned(
                    top: 0,
                    right: 5,
                    child: Container(
                        child: Text((selectionIndex + 1).toString()),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black),
                            color: Colors.white)))
                : const SizedBox.shrink())
          ],
        ));
  }
}
