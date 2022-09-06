import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/pages/login.dart';
import 'package:hackathon/pages/timelineScreen.dart';
import 'package:hackathon/pages/screen2.dart';

import 'bloc/page_bloc.dart';
import 'pages/projectSelection.dart';
import 'utils/screen.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<PageBloc>(
      create: (context) => PageBloc(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hackathon',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Hackathon'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget renderScreen(Screen screen) {
    switch (screen) {
      case Screen.Timeline:
        return const TimelineScreen();
      case Screen.Screen2:
        return const Screen2();
      case Screen.ProjectSelection:
        return const ProjectSelection();
      case Screen.Login:
      default:
        return const Loginscreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageBloc, PageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: renderScreen(state.screen),
        );
      },
    );
  }
}
