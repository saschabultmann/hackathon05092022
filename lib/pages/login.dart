import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/page_bloc.dart';
import '../utils/screen.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        SizedBox(
          height: 70,
          width: 250,
          child: ElevatedButton(
              onPressed: () => BlocProvider.of<PageBloc>(context)
                  .add(PageChange(Screen.ProjectSelection)),
              child: const Text("Manuell", style: TextStyle(fontSize: 30))),
        ),
        SizedBox(height: 50),
        SizedBox(
          height: 70,
          width: 250,
          child: ElevatedButton(
              onPressed: () => BlocProvider.of<PageBloc>(context)
                  .add(PageChange(Screen.Screen2)),
              child:
                  const Text("Kontrolliert", style: TextStyle(fontSize: 30))),
        ),
        SizedBox(height: 50),
        SizedBox(
          height: 70,
          width: 250,
          child: ElevatedButton(
              onPressed: () => BlocProvider.of<PageBloc>(context)
                  .add(PageChange(Screen.Screen3)),
              child:
                  const Text("Vollautomatik", style: TextStyle(fontSize: 30))),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    ));
  }
}
