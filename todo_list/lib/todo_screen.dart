import 'package:flutter/material.dart';
import 'task.dart';

class TodoScreen extends StatefulWidget {
  final String title;

  const TodoScreen({super.key, required this.title});

  @override
  // ignore: library_private_types_in_public_api
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<Task> tasks = []; 

  void addTask(String taskName) {
    setState(() {
      tasks.add(Task(name: taskName, isDone: false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('To-Do List'),
      // ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () {
              setState(() {
                tasks.removeAt(index);
              });
            },
            child: ListTile(
              title: Text(tasks[index].name),  // tasks[index].name instead of tasks[index]
              trailing: Checkbox(
                value: tasks[index].isDone,
                onChanged: (bool? value) {
                  setState(() {
                    tasks[index].isDone = value!;
                  });
                },
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Edit task'),
                      content: NewTaskDialog(
                        onSubmit: (value) {
                          setState(() {
                            tasks[index].name = value;  // tasks[index].name instead of tasks[index]
                          });
                        },
                        controller: TextEditingController(text: tasks[index].name),  // tasks[index].name instead of tasks[index]
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('New task'),
                content: NewTaskDialog(
                  onSubmit: (value) {
                    setState(() {
                      tasks.add(Task(name: value, isDone: false));
                    });
                  },
                  controller: TextEditingController(),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NewTaskDialog extends StatelessWidget {
  final void Function(String) onSubmit;
  final TextEditingController controller;

  const NewTaskDialog({super.key, required this.onSubmit, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: (value) {
        onSubmit(value);
        Navigator.of(context).pop();
      },
    );
  }
}
