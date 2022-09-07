import 'package:hackathon/utils/project.dart';

class DB {
  static const projects = {
    1: 'Dreihöfe',
    2: 'Am Obstgarten',
    3: 'Am Hochkamp',
    4: 'JVA Vechta',
    5: 'Havenkant',
    6: 'Core',
    7: 'ARGE Kraftwerk Datteln',
    8: 'Siebeneichen',
    9: 'Meier Schulze',
    10: 'Eurogate Terminal',
    11: 'Wohnquatier Grüne Uhle'
  };

  static List<Project> getAllProjects() =>
      projects.entries.map((e) => Project(e.key, e.value)).toList();

  static Project getProjectById(int id) => Project(id, projects[id]!);
}
