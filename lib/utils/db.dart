import 'package:hackathon/utils/project.dart';

class DB {
  static const projects = {
    1: 'Baustelle 1',
    2: 'Baustelle 2',
    3: 'Baustelle 3',
    4: 'Baustelle 4',
    5: 'Baustelle 5',
    6: 'Baustelle 6',
    7: 'Baustelle 7',
    8: 'Baustelle 8',
    9: 'Baustelle 9',
    10: 'Baustelle 10',
    11: 'Baustelle 11',
    12: 'Baustelle 12',
    13: 'Baustelle 13',
    14: 'Baustelle 14',
  };

  static List<Project> getAllProjects() =>
      projects.entries.map((e) => Project(e.key, e.value)).toList();

  static Project getProjectById(int id) => Project(id, projects[id]!);
}
