import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_bloc/blocs/task/task_bloc.dart';
import 'package:todo_bloc/models/models.dart';

import '../screens/edit_task_screen.dart';
import 'widgets.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});
  final TaskModel task;

  _removeOrDeleteTask(BuildContext context, TaskModel task) {
    task.isDelete!
        ? context.read<TaskBloc>().add(DeleteTask(task: task))
        : context.read<TaskBloc>().add(RemoveTask(task: task));
  }

  _editTask(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: EditTaskScreen(
              oldTask: task,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: 40,
            child: Icon(
                task.isFavourite == false ? Icons.star_outline : Icons.star)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    decoration: task.isDone!
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
              Text(DateFormat()
                  .add_yMEd()
                  .add_Hms()
                  .format(DateTime.parse(task.date)))
            ],
          ),
        ),
        Row(
          children: [
            Checkbox(
              value: task.isDone,
              onChanged: task.isDelete == false
                  ? (value) {
                      context.read<TaskBloc>().add(UpdateTask(task: task));
                    }
                  : null,
            ),
            PopupMenu(
              task: task,
              cancelOrDeleteCallBack: () => _removeOrDeleteTask(context, task),
              likeOrDislikeCallBack: () =>
                  context.read<TaskBloc>().add(FavouriteTask(task: task)),
              editTaskCallBack: () {
                Navigator.of(context).pop();
                _editTask(context);
              },
              restoreTaskCallBack: () =>
                  context.read<TaskBloc>().add(RestoreTask(task: task)),
            )
          ],
        ),
      ],
    );
  }
}
