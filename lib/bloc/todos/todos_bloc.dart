import 'package:demo_revised_project/bloc/todos/todos_event.dart';
import 'package:demo_revised_project/bloc/todos/todos_state.dart';
import 'package:demo_revised_project/models/response/api_response_status.dart';
import 'package:demo_revised_project/models/todos/todos.dart';
import 'package:demo_revised_project/repository/todos_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRepository _todosRepository;

  TodosBloc({
    required TodosRepository todosRepository,
  })  : _todosRepository = todosRepository,
        super(TodosState.initial()) {
    on<FetchUserTodosList>(_onFetchUserTodosList);
  }

  void _onFetchUserTodosList(
    FetchUserTodosList event,
    Emitter<TodosState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    await emit.forEach<ApiResponseStatus<List<Todos>>>(
      _todosRepository.fetchUserTodosList(event.userId),
      onData: (response) {
        if (response.isSuccessful) {
          return state.copyWith(
            isLoading: false,
            isFailed: false,
            data: response.data,
            error: response.error,
          );
        } else {
          return state.copyWith(
            isLoading: false,
            isFailed: true,
            error: response.error,
          );
        }
      },
      onError: (error, stackTrace) {
        return state.copyWith(
          isLoading: false,
          isFailed: true,
          error: error.toString(),
        );
      },
    );
  }
}
