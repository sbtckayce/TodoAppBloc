import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/models/models.dart';
import 'package:todo_bloc/widgets/widgets.dart';

import '../blocs/bloc_export.dart';
import 'screens.dart';

class RecybinScreen extends StatelessWidget {
  const RecybinScreen({super.key});
 

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Recybin'),
            actions: [
              IconButton(onPressed: (){
                context.read<TaskBloc>().add(DeleteAllTask());

              }, icon:const Icon(Icons.delete_forever))
            ],
          ),
          
          drawer: MyDrawer(),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                Center(
                  child: Chip(label: Text('${state.removedTasks.length} Tasks')),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: state.removedTasks.length,
                  itemBuilder: (context, index) {
                    return TaskItem(task: state.removedTasks[index]);
                  },
                ))
              ],
            ),
          ),
          
        );
      },
    );
  }
}

