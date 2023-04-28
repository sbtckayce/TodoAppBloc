import 'package:flutter/material.dart';
import 'package:todo_bloc/models/models.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({
    super.key, required this.cancelOrDeleteCallBack, required this.task, required this.likeOrDislikeCallBack, required this.editTaskCallBack, required this.restoreTaskCallBack,
  });
  final VoidCallback cancelOrDeleteCallBack;
  final VoidCallback likeOrDislikeCallBack;
  final VoidCallback editTaskCallBack;
  final VoidCallback restoreTaskCallBack;
  final TaskModel task;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: task.isDelete ==false ? (context) => [
        PopupMenuItem(
            onTap: null,
            child: TextButton.icon(
                onPressed: editTaskCallBack,
                icon: const Icon(Icons.edit),
                label: const Text('Edit')),),
        PopupMenuItem(
            child: TextButton.icon(
                onPressed: null,
                icon: task.isFavourite == false ?const Icon(Icons.bookmark_add_outlined) :const Icon(Icons.bookmark_remove),
                label: task.isFavourite == false ? const Text('Add to Bookmarks')
                : const Text('Remove form Bookmarks')
                ),
                onTap: (){
                  likeOrDislikeCallBack();
                }),
        PopupMenuItem(
            child: TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.delete),
                label: const Text('Delete')),
                onTap: (){
                  cancelOrDeleteCallBack();
                })
      ] : (context)=>

      [
        PopupMenuItem(
            child: TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.restore),
                label: const Text('Restore')),
                onTap: (){
                  restoreTaskCallBack();
                }),
                 PopupMenuItem(
            child: TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.delete_forever),
                label: const Text('Delete Forever')),
                onTap: (){
                  cancelOrDeleteCallBack();
                })
      ],
    );
  }
}