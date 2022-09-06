import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/page_bloc.dart';
import '../utils/db.dart';
import '../utils/dragProject.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  State<TimelineScreen> createState() => TimelineScreenState();
}

class TimelineScreenState extends State<TimelineScreen> {
  List<Widget> generateItems(List<DragProject?> list) {
    var res = <Widget>[];
    double height = 0;
    for (var i = 0; i < list.length; i++) {
      if (list[i] == null) {
        res.add(SizedBox(height: 1.0, key: Key(i.toString())));
        height++;
      } else {
        height += list[i]!.duration.toDouble();
        res.add(SizedBox(
          height: list[i]!.duration.toDouble(),
          key: Key(i.toString()),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Column(
              children: [
                Text(DB.getProjectById(list[i]!.projectId).name,
                    style: const TextStyle(fontSize: 30)),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ));
      }
    }
    print(height);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageBloc, PageState>(
      builder: (context, state) {
        return Row(
          children: [
            SizedBox(
                width: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      Text(
                        "08:00",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 59),
                      SizedBox(
                        height: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 59),
                      SizedBox(
                        height: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 59),
                      SizedBox(
                        height: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Text(
                        "12:00",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 59),
                      SizedBox(
                        height: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 59),
                      SizedBox(
                        height: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 59),
                      SizedBox(
                        height: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Text(
                        "16:00",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 55)
                    ],
                  ),
                )),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: ReorderableListView(
                children: generateItems(state.projectList),
                onReorder: (oldIndex, newIndex) => {
                  BlocProvider.of<PageBloc>(context)
                      .add(MoveProject(oldIndex, newIndex))
                },
              ),
            ),
            SizedBox(
              width: 20,
            )
          ],
        );
      },
    );
  }
}
