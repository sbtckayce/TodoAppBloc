import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/models/models.dart';
import 'package:todo_bloc/widgets/widgets.dart';

import '../blocs/bloc_export.dart';
import 'screens.dart';

class CompleteTaskScreen extends StatelessWidget {
  CompleteTaskScreen({super.key});
  final TextEditingController _taskController = TextEditingController();
  
  
  

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Complete Tasks'),
          ),
          drawer:const MyDrawer(),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                Center(
                  child: Chip(label: Text('${state.completeTasks.length} Tasks')),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: state.completeTasks.length,
                  itemBuilder: (context, index) {
                    return TaskItem(task: state.completeTasks[index]);
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

