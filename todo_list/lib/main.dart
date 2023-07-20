import 'package:flutter/material.dart';
import 'package:todo_list/todo_screen.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  final ValueNotifier<ThemeMode> _themeMode = ValueNotifier(ThemeMode.light);

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeMode,
      builder: (_, mode, __) {
        return MaterialApp(
          title: 'Flutter To-Do List',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.dark,
          ),
          themeMode: mode,
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Flutter To-Do List'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.brightness_6),
                  onPressed: () {
                    if (_themeMode.value == ThemeMode.light) {
                      _themeMode.value = ThemeMode.dark;
                    } else {
                      _themeMode.value = ThemeMode.light;
                    }
                  },
                ),
              ],
            ),
            body: const TodoScreen(title: 'Flutter To-Do List'),
          ),
        );
      },
    );
  }
}