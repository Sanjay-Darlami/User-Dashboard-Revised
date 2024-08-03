import 'package:demo_revised_project/models/todos/todos.dart';
import 'package:equatable/equatable.dart';

class TodosState extends Equatable {
  final bool isLoading;
  final bool isFailed;
  final List<Todos>? data;
  final String? error;

  const TodosState({
    required this.isLoading,
    required this.isFailed,
    this.data,
    this.error,
  });

  TodosState.initial()
      : isLoading = false,
        isFailed = false,
        data = [],
        error = null;

  TodosState copyWith({
    bool? isLoading,
    bool? isFailed,
    List<Todos>? data,
    String? error,
  }) {
    return TodosState(
      isLoading: isLoading ?? this.isLoading,
      isFailed: isFailed ?? this.isFailed,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isFailed, data, error];
}
