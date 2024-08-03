import 'package:equatable/equatable.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserTodosList extends TodosEvent {
  final int userId;

  const FetchUserTodosList(this.userId);

  @override
  List<Object?> get props => [userId];
}
