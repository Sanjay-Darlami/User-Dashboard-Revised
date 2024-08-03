import 'package:demo_revised_project/models/user/user.dart';
import 'package:demo_revised_project/network/url.dart';
import 'package:demo_revised_project/models/response/api_response_status.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final Dio _dio;

  UserRepository({required Dio dio}) : _dio = dio;

  Future<ApiResponseStatus<List<User>>> fetchUserList() async {
    List<User>? users;

    try {
      final response = await _dio.get(usersUrl);

      users = (response.data as List<dynamic>).map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return User.fromJson(map);
      }).toList();
      return ApiResponseStatus(
        isSuccessful: true,
        data: users,
        error: null,
        fromLocal: false,
      );
    } on DioException catch (error) {
      return ApiResponseStatus(
        isSuccessful: false,
        data: users,
        error: error.message,
      );
    } catch (e) {
      return ApiResponseStatus(
        isSuccessful: false,
        data: users,
        error: e.toString(),
      );
    }
  }
}
