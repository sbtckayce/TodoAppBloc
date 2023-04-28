import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/router/router.dart';
import 'package:todo_bloc/screens/recybin_screen.dart';

import '../blocs/bloc_export.dart';
import '../blocs/switch/switch_bloc.dart';
import '../screens/screens.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
                color: Colors.grey,
                child: Text(
                  'Task Drawer',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  return ListTile(
                    onTap: () =>
                        AppRoute.push(widget: PendingTaskScreen(), context: context),
                    leading: const Icon(Icons.folder_special),
                    title: const Text('My Tasks'),
                    trailing: Text('${state.pendingTasks.length} | ${state.completeTasks.length}',
                  style: Theme.of(context).textTheme.titleMedium),
                  );
                },
              ),
              const Divider(),
              BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  return ListTile(
                    onTap: () => AppRoute.push(
                        widget:const RecybinScreen(), context: context),
                    leading: const Icon(Icons.delete),
                    title: const Text('Bin'),
                    trailing: Text('${state.removedTasks.length}',
                  style: Theme.of(context).textTheme.titleMedium),
                  );
                },
              ),
              BlocBuilder<SwitchBloc, SwitchState>(
                builder: (context, state) {
                  return Switch(value: state.switchValue ,
                   onChanged: (value) {
                     value ? context.read<SwitchBloc>().add(SwitchOnEvent()) : context.read<SwitchBloc>().add(SwitchOffEvent());
                   
                   },);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
