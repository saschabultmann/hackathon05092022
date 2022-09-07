class DragProject {
  DragProject(this.projectId, this.duration, this.isRealBreak);

  final int? projectId;
  int duration;
  bool isRealBreak;
  bool get isBreak => projectId == null;
}
