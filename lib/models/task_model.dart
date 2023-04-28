import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  String? id;
  String title;
  String description;
  String date;
  bool? isDone;
  bool? isDelete;
  bool? isFavourite;
  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isDone,
    this.isDelete,
    this.isFavourite,
  }) {
    isDone = isDone ?? false;
    isDelete = isDelete ?? false;
    isFavourite = isFavourite ?? false;
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? date,
    bool? isDone,
    bool? isDelete,
    bool? isFavourite,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
      isDelete: isDelete ?? this.isDelete,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'isDone': isDone,
      'isDelete': isDelete,
      'isFavourite': isFavourite,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      isDone: map['isDone'],
      isDelete: map['isDelete'],
      isFavourite: map['isFavourite'],
    );
  }

  @override
  String toString() =>
      'TaskModel(title: $title, isDone: $isDone, isDelete: $isDelete)';

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.isDone == isDone &&
        other.isDelete == isDelete;
  }

  @override
  int get hashCode => title.hashCode ^ isDone.hashCode ^ isDelete.hashCode;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        date,
        isDone,
        isDelete,
        isFavourite,
      ];
}
