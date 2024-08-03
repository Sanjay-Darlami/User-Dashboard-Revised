import 'package:demo_revised_project/models/response/api_response_status.dart';
import 'package:demo_revised_project/models/todos/todos.dart';
import 'package:demo_revised_project/network/url.dart';
import 'package:dio/dio.dart';

class TodosRepository {
  final Dio _dio;

  TodosRepository({required Dio dio}) : _dio = dio;

  Stream<ApiResponseStatus<List<Todos>>> fetchUserTodosList(int userId) async* {
    List<Todos>? todos;
    try {
      final response = await _dio.get("$usersUrl/$userId/todos");
      todos = (response.data as List<dynamic>).map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Todos.fromJson(map);
      }).toList();

      yield ApiResponseStatus(
        isSuccessful: true,
        data: todos,
        error: null,
        fromLocal: false,
      );
    } on DioException catch (error) {
      yield ApiResponseStatus(
        isSuccessful: false,
        data: todos,
        error: error.message,
      );
    } catch (e) {
      yield ApiResponseStatus(
        isSuccessful: false,
        data: todos,
        error: e.toString(),
      );
    }
  }
}
