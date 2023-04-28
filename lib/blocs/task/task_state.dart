part of 'task_bloc.dart';

class TaskState extends Equatable {
  final List<TaskModel> pendingTasks;
  final List<TaskModel> completeTasks;
  final List<TaskModel> favouriteTasks;
  final List<TaskModel> removedTasks;
 const TaskState({
    this.pendingTasks = const <TaskModel>[],
    this.completeTasks = const <TaskModel>[],
    this.favouriteTasks = const <TaskModel>[],
    this.removedTasks = const <TaskModel>[],
  });
  @override
  List<Object> get props =>
      [pendingTasks, completeTasks, favouriteTasks, removedTasks];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pendingTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'completeTasks': completeTasks.map((x) => x.toMap()).toList(),
      'favouriteTasks': favouriteTasks.map((x) => x.toMap()).toList(),
      'removedTasks': removedTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TaskState.fromMap(Map<String, dynamic> map) {
    return TaskState(
      pendingTasks: List<TaskModel>.from(
        (map['pendingTasks'] as List<int>).map<TaskModel>(
          (x) => TaskModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      completeTasks: List<TaskModel>.from(
        (map['completeTasks'] as List<int>).map<TaskModel>(
          (x) => TaskModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      favouriteTasks: List<TaskModel>.from(
        (map['favouriteTasks'] as List<int>).map<TaskModel>(
          (x) => TaskModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      removedTasks: List<TaskModel>.from(
        (map['removedTasks'] as List<int>).map<TaskModel>(
          (x) => TaskModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
