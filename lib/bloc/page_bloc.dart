import 'package:bloc/bloc.dart';

import '../utils/dragProject.dart';
import '../utils/screen.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(PageState(Screen.Login, [], [])) {
    on<PageChange>((event, emit) {
      var newProjectList = state.projectList;
      if (event.screen == Screen.Timeline) {
        var res = <DragProject?>[];
        for (var i = 0; i < 60; i++) {
          res.add(null);
        }
        var height = 8 / state.selectedProjects.length * 60;
        for (var project in state.selectedProjects) {
          res.add(DragProject(project, height.toInt()));
        }
        for (var i = 0; i < 60; i++) {
          res.add(null);
        }
        newProjectList = res;
      }
      emit(PageState(event.screen, state.selectedProjects, newProjectList));
    });
    on<ProjectSelectionChange>((event, emit) {
      emit(PageState(state.screen, event.selectedProjects, state.projectList));
    });
    on<AddProjectToSelection>((event, emit) {
      if (!state.selectedProjects.contains(event.projectId)) {
        var newList = state.selectedProjects;
        newList.add(event.projectId);
        emit(PageState(state.screen, newList, state.projectList));
      }
    });
    on<RemoveProjectFromSelection>((event, emit) {
      if (state.selectedProjects.contains(event.projectId)) {
        var newList = state.selectedProjects;
        newList.remove(event.projectId);
        emit(PageState(state.screen, newList, state.projectList));
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
      emit(PageState(state.screen, state.selectedProjects, newList));
    });
  }
}
