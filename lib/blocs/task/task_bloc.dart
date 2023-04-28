import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/models.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskState()) {
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
    on<UpdateTask>(_onUpdateTask);
    on<RemoveTask>(_onRemoveTask);
    on<FavouriteTask>(_onFavouriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTask>(_onDeleteAllTask);
  }
  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
        pendingTasks: List.from(state.pendingTasks)..add(event.task),
        removedTasks: state.removedTasks,
        completeTasks: state.completeTasks,
        favouriteTasks: state.favouriteTasks));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    final state = this.state;

    emit(TaskState(
        pendingTasks: state.pendingTasks,
        completeTasks: state.completeTasks,
        favouriteTasks: state.favouriteTasks,
        removedTasks: List.from(state.removedTasks)..remove(event.task)));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TaskState> emit) {
    final state = this.state;

    emit(TaskState(
        pendingTasks: List.from(state.pendingTasks)..remove(event.task),
        completeTasks: List.from(state.completeTasks)..remove(event.task),
        favouriteTasks: List.from(state.favouriteTasks)..remove(event.task),
        removedTasks: List.from(state.removedTasks)
          ..add(event.task.copyWith(isDelete: true))));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;
    List<TaskModel> pendingTasks = state.pendingTasks;
    List<TaskModel> completeTasks = state.completeTasks;

    task.isDone == false
        ? {
            pendingTasks = List.from(pendingTasks)..remove(event.task),
            completeTasks = List.from(completeTasks)
              ..insert(0, task.copyWith(isDone: true))
          }
        : {
            completeTasks = List.from(completeTasks)..remove(event.task),
            pendingTasks = List.from(pendingTasks)
              ..insert(0, task.copyWith(isDone: false))
          };
    emit(TaskState(
        pendingTasks: pendingTasks,
        completeTasks: completeTasks,
        favouriteTasks: state.favouriteTasks,
        removedTasks: state.removedTasks));
  }

  void _onFavouriteTask(FavouriteTask event, Emitter<TaskState> emit) {
    final state = this.state;
    List<TaskModel> pendingTasks = state.pendingTasks;
    List<TaskModel> completeTasks = state.completeTasks;
    List<TaskModel> favouriteTasks = state.favouriteTasks;

    if (event.task.isDone == false) {
      if (event.task.isFavourite == false) {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: true));
        favouriteTasks = List.from(favouriteTasks)
          ..insert(0, event.task.copyWith(isFavourite: true));
      } else {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: false));
        favouriteTasks = List.from(favouriteTasks)..remove(event.task);
      }
    } else {
      if (event.task.isFavourite == false) {
        var taskIndex = completeTasks.indexOf(event.task);
        completeTasks = List.from(completeTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: true));
        favouriteTasks = List.from(favouriteTasks)
          ..insert(0, event.task.copyWith(isFavourite: true));
      } else {
        var taskIndex = completeTasks.indexOf(event.task);
        completeTasks = List.from(completeTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: false));
        favouriteTasks = List.from(favouriteTasks)..remove(event.task);
      }
    }
    emit(TaskState(
        pendingTasks: pendingTasks,
        completeTasks: completeTasks,
        favouriteTasks: favouriteTasks,
        removedTasks: state.removedTasks));
  }

  void _onEditTask(EditTask event, Emitter<TaskState> emit) {
    final state = this.state;
    List<TaskModel> favouriteTasks = state.favouriteTasks;
    if (event.oldTask.isFavourite == true) {
      favouriteTasks = List.from(favouriteTasks)
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }
    emit(TaskState(
        pendingTasks: List.from(state.pendingTasks)
          ..remove(event.oldTask)
          ..insert(0, event.newTask),
        completeTasks: List.from(state.completeTasks)..remove(event.oldTask),
        favouriteTasks: favouriteTasks,
        removedTasks: state.removedTasks));
  }
  void _onRestoreTask(RestoreTask event,Emitter<TaskState>emit){
    final state=this.state;
    emit(
      TaskState(
        removedTasks: List.from(state.removedTasks)..remove(event.task),
        pendingTasks: List.from(state.pendingTasks)..insert(0, event.task.copyWith(isDelete: false,isDone: false,isFavourite: false)),
        completeTasks: state.completeTasks,
        favouriteTasks: state.favouriteTasks
      )
    );
  }
  void _onDeleteAllTask(DeleteAllTask event,Emitter<TaskState>emit){
    final state= this.state;
    emit(
      TaskState(
        removedTasks:  List.from(state.removedTasks)..clear(),
        pendingTasks: state.pendingTasks,
        completeTasks: state.completeTasks,
        favouriteTasks: state.favouriteTasks
      )
    );
  }
  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return state.toMap();
  }
}
