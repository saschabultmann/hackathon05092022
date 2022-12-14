part of 'page_bloc.dart';

abstract class PageEvent {}

class PageChange extends PageEvent {
  final Screen screen;
  bool useFakeData;
  PageChange(this.screen, {this.useFakeData = false});
}

class ProjectSelectionChange extends PageEvent {
  final List<int> selectedProjects;
  ProjectSelectionChange(this.selectedProjects);
}

class AddProjectToSelection extends PageEvent {
  final int projectId;
  AddProjectToSelection(this.projectId);
}

class RemoveProjectFromSelection extends PageEvent {
  final int projectId;
  RemoveProjectFromSelection(this.projectId);
}

class MoveProject extends PageEvent {
  final int oldIndex;
  final int newIndex;
  MoveProject(this.oldIndex, this.newIndex);
}

class StartDrag extends PageEvent {}

class AddBreak extends PageEvent {
  final DragProject project;
  AddBreak(this.project);
}
