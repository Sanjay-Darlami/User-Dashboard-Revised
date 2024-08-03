import 'package:demo_revised_project/bloc/todos/todos_bloc.dart';
import 'package:demo_revised_project/bloc/todos/todos_event.dart';
import 'package:demo_revised_project/bloc/todos/todos_state.dart';
import 'package:demo_revised_project/dependency_injection.dart';
import 'package:demo_revised_project/models/todos/todos.dart';
import 'package:demo_revised_project/models/user/user.dart';
import 'package:demo_revised_project/pages/todos/todos_widget.dart';
import 'package:demo_revised_project/shimmer/todos_shimmer.dart';
import 'package:demo_revised_project/utils/snackbar_util.dart';
import 'package:demo_revised_project/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosPage extends StatefulWidget {
  final User user;
  const TodosPage({super.key, required this.user});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  @override
  void initState() {
    getIt<TodosBloc>().add(FetchUserTodosList(widget.user.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TodosBloc, TodosState>(
        bloc: getIt<TodosBloc>(),
        builder: (context, TodosState state) {
          if (state.isLoading) {
            return const TodosShimmer();
          } else if (state.data != null) {
            final List<Todos> todosList = state.data ?? [];
            return ListView.builder(
              itemCount: todosList.length,
              itemBuilder: (context, index) {
                return TodosWidget(todos: todosList[index]);
              },
            );
          } else {
            return CustomErrorWidget(errorMessage: state.error!);
          }
        },
        listener: (context, TodosState state) {
          if (state.error != null) {
            SnackbarUtils.showSnackbar(context, "Something went wrong!");
          }
        },
      ),
    );
  }
}
