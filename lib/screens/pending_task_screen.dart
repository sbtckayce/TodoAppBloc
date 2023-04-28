import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/models/models.dart';
import 'package:todo_bloc/widgets/widgets.dart';

import '../blocs/bloc_export.dart';
import 'screens.dart';

class PendingTaskScreen extends StatelessWidget {
 const PendingTaskScreen({super.key});

  _addTask(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: AddTaskScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Pending Tasks'),
            actions: [
              IconButton(
                  onPressed: () {
                    _addTask(context);
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
          drawer: const MyDrawer(),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                Center(
                  child: Chip(
                      label: Text(
                          '${state.pendingTasks.length} Pending | ${state.completeTasks.length} Complete')),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: ExpansionPanelList.radio(
                      children: state.pendingTasks
                          .map((task) => ExpansionPanelRadio(
                                value: task.id!,
                                headerBuilder: (context, isExpanded) =>
                                    TaskItem(task: task),
                                body: ListTile(
                                  title: SelectableText.rich(TextSpan(children: [
                                    const TextSpan(
                                        text: 'Title\n',
                                        style:
                                            TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: task.title),
                                    const TextSpan(
                                        text: '\n\nDescription\n',
                                        style:
                                            TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: task.description),
                                  ])),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
