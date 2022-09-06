part of 'page_bloc.dart';

class PageState {
  final Screen screen;
  final List<int> selectedProjects;
  final List<DragProject?> projectList;

  PageState(this.screen, this.selectedProjects, this.projectList);
}
