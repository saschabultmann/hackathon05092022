import 'package:hackathon/utils/project.dart';

class DB {
  static const projects = {
    1: 'Baustelle 1',
    2: 'Baustelle 2',
    3: 'Baustelle 3',
    4: 'Baustelle 4',
    5: 'Baustelle 5',
    6: 'Baustelle 6',
  };

  static List<Project> getAllProjects() =>
      projects.entries.map((e) => Project(e.key, e.value)).toList();

  static Project getProjectById(int id) => Project(id, projects[id]!);
}
