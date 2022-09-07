import 'package:bloc/bloc.dart';

import '../utils/dragProject.dart';
import '../utils/screen.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(PageState(Screen.Login, [], [], false)) {
    on<PageChange>((event, emit) {
      var newProjectList = state.projectList;
      var newSelectedProjects = state.selectedProjects;
      if (event.screen == Screen.Timeline) {
        var res = <DragProject>[];
        if (event.useFakeData) {
          res.add(DragProject(null, 60, false));
          res.add(DragProject(1, 120, false));
          res.add(DragProject(null, 15, true));
          res.add(DragProject(1, 180, false));
          res.add(DragProject(null, 30, true));
          res.add(DragProject(2, 135, false));
          res.add(DragProject(null, 60, false));
        } else {
          res.add(DragProject(null, 60, false));
          var height = 8 / state.selectedProjects.length * 60;
          for (var i = 0; i < state.selectedProjects.length; i++) {
            res.add(
                DragProject(state.selectedProjects[i], height.toInt(), false));
          }
          res.add(DragProject(null, 60, false));
        }
        newProjectList = res;
      } else if (event.screen == Screen.Login) {
        newSelectedProjects = [];
      }
      emit(PageState(event.screen, newSelectedProjects, newProjectList,
          state.isDraggingProject));
    });
    on<ProjectSelectionChange>((event, emit) {
      emit(PageState(state.screen, event.selectedProjects, state.projectList,
          state.isDraggingProject));
    });
    on<AddProjectToSelection>((event, emit) {
      if (!state.selectedProjects.contains(event.projectId)) {
        var newList = state.selectedProjects;
        newList.add(event.projectId);
        emit(PageState(
            state.screen, newList, state.projectList, state.isDraggingProject));
      }
    });
    on<RemoveProjectFromSelection>((event, emit) {
      if (state.selectedProjects.contains(event.projectId)) {
        var newList = state.selectedProjects;
        newList.remove(event.projectId);
        emit(PageState(
            state.screen, newList, state.projectList, state.isDraggingProject));
      }
    });
    on<MoveProject>((event, emit) {
      var newIndex = event.newIndex;
      if (event.oldIndex < event.newIndex) {
        newIndex -= 1;
      }
      var newList = state.projectList;
      final item = newList.removeAt(event.oldIndex);
      newList.insert(newIndex, item);
      emit(PageState(
          state.screen, state.selectedProjects, fixBreaks(newList), false));
    });
    on<StartDrag>(
      (event, emit) {
        emit(PageState(
            state.screen, state.selectedProjects, state.projectList, true));
      },
    );
    on<AddBreak>((event, emit) {
      var newList = state.projectList;
      var idx = state.projectList.indexOf(event.project);
      if (idx >= 0) {
        var entry = newList[idx];
        if (entry.duration > 60) {
          var newDuration = (entry.duration - 30) / 2;
          entry.duration = newDuration.toInt();
          newList.insert(idx + 1, DragProject(null, 30, true));
          newList.insert(idx + 2,
              DragProject(entry.projectId, newDuration.toInt(), false));
          emit(PageState(state.screen, state.selectedProjects, newList,
              state.isDraggingProject));
        }
      }
    });
  }

  List<DragProject> fixBreaks(List<DragProject> list) {
    var newList = list
        .where((element) => !element.isBreak || element.isRealBreak)
        .toList();
    if (newList[0].isBreak) {
      newList[1].duration += newList[0].duration;
      newList[0].duration = 60;
      newList[0].isRealBreak = false;
    } else {
      newList.insert(0, DragProject(null, 60, false));
    }
    if (newList[newList.length - 1].isBreak) {
      newList[newList.length - 2].duration +=
          newList[newList.length - 1].duration;
      newList[newList.length - 1].duration = 60;
      newList[newList.length - 1].isRealBreak = false;
    } else {
      newList.add(DragProject(null, 60, false));
    }

    var mergedBreaksList = <DragProject>[];

    for (var i = 1; i < newList.length; i++) {
      var current = newList[i];
      var previous = newList[i - 1];

      if (current.isRealBreak && previous.isRealBreak ||
          current.projectId == previous.projectId) {
        newList[i].duration += previous.duration;
      } else {
        mergedBreaksList.add(previous);
      }

      if (i == newList.length - 1) {
        mergedBreaksList.add(current);
      }
    }
    return mergedBreaksList;
  }
}
