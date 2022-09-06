import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/utils/db.dart';

import '../bloc/page_bloc.dart';
import '../utils/screen.dart';
import '../widgets/bubble.dart';

class ProjectSelection extends StatelessWidget {
  const ProjectSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageBloc, PageState>(
      builder: (context, state) {
        return Stack(
          children: [
            Wrap(
              children: DB
                  .getAllProjects()
                  .map(
                    (p) => Bubble(
                      selectionIndex: state.selectedProjects.indexOf(p.id),
                      project: p,
                      onBubbleTap: (projectId) => {
                        if (state.selectedProjects.contains(p.id))
                          {
                            BlocProvider.of<PageBloc>(context)
                                .add(RemoveProjectFromSelection(p.id))
                          }
                        else
                          {
                            BlocProvider.of<PageBloc>(context)
                                .add(AddProjectToSelection(p.id))
                          }
                      },
                    ),
                  )
                  .toList(),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  child: const Text("Weiter"),
                  onPressed: () => {
                    BlocProvider.of<PageBloc>(context)
                        .add(PageChange(Screen.Timeline))
                  },
                ))
          ],
        );
      },
    );
  }
}
