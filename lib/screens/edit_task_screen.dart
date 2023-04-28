import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../blocs/bloc_export.dart';
import '../models/models.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({
    super.key,
    required this.oldTask,
  });
  final TaskModel oldTask;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descController = TextEditingController();
  @override
  void initState() {
    _titleController.text = widget.oldTask.title;
    _descController.text = widget.oldTask.description;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Edit task',
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
                    TaskModel newTask = TaskModel(
                        id: widget.oldTask.id,
                        date: DateTime.now().toString(),
                        title: _titleController.text,
                        description: _descController.text,
                        isFavourite: widget.oldTask.isFavourite,
                        isDone: false);
                    context.read<TaskBloc>().add(
                        EditTask(oldTask: widget.oldTask, newTask: newTask));
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Edit Task',
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
