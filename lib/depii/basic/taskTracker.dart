import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tasktracker extends StatefulWidget {
  const Tasktracker({super.key});

  @override
  State<Tasktracker> createState() => _TasktrackerState();
}

class _TasktrackerState extends State<Tasktracker> {
  late List<bool> chVa = [];
  List<String> tasks = [];
  TextEditingController _task = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Task Tracker',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _task,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter a task',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_task.text.isNotEmpty) {
                        if (tasks.contains(_task.text)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(seconds: 8),
                              backgroundColor: Colors.red,
                              content: Text('Your Tasks Contain this task',),
                            ),
                          );
                        } else {
                          tasks.add(_task.text);
                          chVa.add(false);
                          _task.clear();
                          setState(() {});
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,

                            content: Text('Please Enter Valid task'),
                          ),
                        );
                      }
                    },
                    child: Text('Add'),
                  ),
                ],
              ),

              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: tasks.length,

                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      color: Colors.teal[50],
                      child: ListTile(
                        leading: Checkbox(
                          value: chVa[index],
                          onChanged: (val) {
                            chVa[index] = val!;

                            setState(() {});
                          },
                        ),
                        title: Text('${tasks[index]}'),
                        subtitle: Text('Do this Task'),
                        trailing: Radio(
                          value: true,

                          fillColor: WidgetStatePropertyAll(Colors.teal),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
