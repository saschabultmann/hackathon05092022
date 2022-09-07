import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/page_bloc.dart';
import '../utils/db.dart';
import '../utils/dragProject.dart';
import '../widgets/addPause.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  State<TimelineScreen> createState() => TimelineScreenState();
}

class TimelineScreenState extends State<TimelineScreen> {
  List<Widget> generateItems(List<DragProject> list, bool isDraggingProject) {
    var res = <Widget>[];
    for (var i = 0; i < list.length; i++) {
      if (list[i].isBreak) {
        if (list[i].isRealBreak) {
          res.add(Break(
              project: list[i], key: GlobalKey(debugLabel: i.toString())));
        } else {
          res.add(SizedBox(
              height: list[i].duration.toDouble(),
              key: GlobalKey(debugLabel: i.toString())));
        }
      } else {
        res.add(DragTargetProject(
            project: list[i], key: GlobalKey(debugLabel: i.toString())));
      }
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageBloc, PageState>(
      builder: (context, state) {
        return Stack(
          children: [
            Row(
              children: [
                const SideTimeLine(),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: ReorderableListView(
                    onReorderStart: (index) =>
                        {BlocProvider.of<PageBloc>(context).add(StartDrag())},
                    children: generateItems(
                        state.projectList, state.isDraggingProject),
                    onReorder: (oldIndex, newIndex) => {
                      BlocProvider.of<PageBloc>(context)
                          .add(MoveProject(oldIndex, newIndex))
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                  child: AddPause(),
                  margin: EdgeInsets.only(left: 15, bottom: 15)),
            )
          ],
        );
      },
    );
  }
}

class DragTargetProject extends StatelessWidget {
  const DragTargetProject({Key? key, required this.project}) : super(key: key);

  final DragProject project;

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (context, List candidateData, rejectedData) {
        return Project(project: project);
      },
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) {
        BlocProvider.of<PageBloc>(context).add(AddBreak(project));
      },
    );
    ;
  }
}

class Break extends StatelessWidget {
  const Break({Key? key, required this.project}) : super(key: key);

  final DragProject project;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: project.duration.toDouble(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white),
        ),
        child: Column(
          children: [
            Text("Pause",
                style: TextStyle(
                    fontSize: (project.duration > 40
                        ? 30
                        : project.duration.toDouble() - 10))),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}

class Project extends StatelessWidget {
  const Project({Key? key, required this.project}) : super(key: key);

  final DragProject project;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: project.duration.toDouble(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white),
        ),
        child: Column(
          children: [
            Text(DB.getProjectById(project.projectId!).name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: (project.duration > 40
                        ? 30
                        : project.duration.toDouble() - 10))),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}

class SideTimeLine extends StatelessWidget {
  const SideTimeLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text(
              "08:00",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 59),
            SizedBox(
              height: 1,
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 59),
            SizedBox(
              height: 1,
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 59),
            SizedBox(
              height: 1,
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              "12:00",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 59),
            SizedBox(
              height: 1,
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 59),
            SizedBox(
              height: 1,
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 59),
            SizedBox(
              height: 1,
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              "16:00",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 55)
          ],
        ),
      ),
    );
  }
}
