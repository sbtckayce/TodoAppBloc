import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../blocs/bloc_export.dart';
import '../models/models.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({
    super.key,
  });

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Add task',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _titleController,
            autofocus: true,
            decoration: InputDecoration(
                label: const Text('Title'),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _descController,
            decoration: InputDecoration(
                label: const Text('Desc'),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {
                    var uuid = Uuid();
                    TaskModel task = TaskModel(
                        id: uuid.v4(),
                        date: DateTime.now().toString(),
                        title: _titleController.text,
                        description: _descController.text);
                    context.read<TaskBloc>().add(AddTask(task: task));
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Add Task',
                    style: Theme.of(context).textTheme.titleMedium,
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.titleMedium,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
