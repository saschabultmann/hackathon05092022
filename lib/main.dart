import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/pages/login.dart';
import 'package:hackathon/pages/timelineScreen.dart';
import 'package:hackathon/pages/controlledScreen.dart';

import 'bloc/page_bloc.dart';
import 'pages/projectSelection.dart';
import 'pages/screenAutomatic.dart';
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
      title: 'TimeCreator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'TimeCreator'),
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
      case Screen.Controlled:
        return const ScreenControlled();
      case Screen.ProjectSelection:
        return const ProjectSelection();
      case Screen.Automatic:
        return const ScreenAutomatic();
      case Screen.Login:
      default:
        return const Loginscreen();
    }
  }

  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageBloc, PageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: renderScreen(state.screen),
          floatingActionButton: state.screen == Screen.Timeline ||
                  state.screen == Screen.ProjectSelection &&
                      state.selectedProjects.isNotEmpty ||
                  state.screen == Screen.Controlled
              ? FloatingActionButton.extended(
                  onPressed: () {
                    if (state.screen == Screen.ProjectSelection) {
                      BlocProvider.of<PageBloc>(context)
                          .add(PageChange(Screen.Timeline));
                    } else if (state.screen == Screen.Controlled) {
                      BlocProvider.of<PageBloc>(context)
                          .add(ProjectSelectionChange([1, 2]));
                      BlocProvider.of<PageBloc>(context)
                          .add(PageChange(Screen.Timeline, useFakeData: true));
                    } else {
                      BlocProvider.of<PageBloc>(context)
                          .add(PageChange(Screen.Login));
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          _timer = Timer(Duration(seconds: 2), () {
                            Navigator.of(context).pop();
                          });
                          return AlertDialog(
                            title: Text("Erfolgreich"),
                            content: Text("Deine Buchung ist abgeschlossen."),
                          );
                        },
                      ).then((val) {
                        if (_timer != null && _timer!.isActive) {
                          _timer!.cancel();
                        }
                      });
                    }
                  },
                  label: state.screen == Screen.ProjectSelection
                      ? Text("Weiter")
                      : Text('Senden'),
                  icon: state.screen == Screen.ProjectSelection
                      ? null
                      : Icon(Icons.check),
                  backgroundColor: Colors.green,
                )
              : null,
        );
      },
    );
  }
}
