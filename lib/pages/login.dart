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
        ElevatedButton(
            onPressed: () => BlocProvider.of<PageBloc>(context)
                .add(PageChange(Screen.ProjectSelection)),
            child: const Text("Screen 1")),
        ElevatedButton(
            onPressed: () => BlocProvider.of<PageBloc>(context)
                .add(PageChange(Screen.Screen2)),
            child: const Text("Screen 2")),
        ElevatedButton(
            onPressed: () => BlocProvider.of<PageBloc>(context)
                .add(PageChange(Screen.Screen3)),
            child: const Text("Screen 3")),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    ));
  }
}
