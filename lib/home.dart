import 'dart:async';
import 'package:flutter/material.dart';
import 'package:to_do/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _taskController = StreamController<List<Task>>.broadcast();
  final _textController = TextEditingController();
  final List<Task> _tasks = [];

  @override
  void dispose() {
    _taskController.close();
    super.dispose();
  }

  void _addTask(String title) {
    _tasks.add(Task(title: title));
    _taskController.sink.add(_tasks);
  }

  void _toggleTaskCompletion(int index) {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    _taskController.sink.add(_tasks);
  }

  void _removeTask(int index) {
    _tasks.removeAt(index);
    _taskController.sink.add(_tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Divider(),
          Expanded(
            child: StreamBuilder<List<Task>>(
              stream: _taskController.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: Text('No hay tareas.'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final task = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12.0, top: 12),
                      child: Card.outlined(
                        child: ListTile(
                          title: Text(
                            task.title,
                            style: TextStyle(
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          leading: Checkbox(
                            value: task.isCompleted,
                            onChanged: (_) => _toggleTaskCompletion(index),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _removeTask(index),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: 'Nueva Tarea',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        _addTask(value);
                      }
                    },
                  ),
                ),
                Container(
                  width: 50.0,
                  height: 65.0,
                  margin: const EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.pink.shade200,
                      )
                      //color: Colors.pink.shade50,
                      ),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    color: Colors.pink,
                    onPressed: () {
                      _addTask(_textController.text);
                      _textController.clear();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
