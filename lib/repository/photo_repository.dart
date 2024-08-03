import 'package:demo_revised_project/models/albums/photos.dart';
import 'package:demo_revised_project/models/response/api_response_status.dart';
import 'package:demo_revised_project/network/url.dart';
import 'package:dio/dio.dart';

class PhotoRepository {
  final Dio _dio;

  PhotoRepository({required Dio dio}) : _dio = dio;

  Stream<ApiResponseStatus<List<Photos>>> fetchUserPhotosList(
      int albumId) async* {
    List<Photos>? photos;
    try {
      final response = await _dio.get("$usersUrl/$albumId/photos");
      photos = (response.data as List<dynamic>).map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Photos.fromJson(map);
      }).toList();

      yield ApiResponseStatus(
        isSuccessful: true,
        data: photos,
        error: null,
        fromLocal: false,
      );
    } on DioException catch (error) {
      yield ApiResponseStatus(
        isSuccessful: false,
        data: photos,
        error: error.message,
      );
    } catch (e) {
      yield ApiResponseStatus(
        isSuccessful: false,
        data: photos,
        error: e.toString(),
      );
    }
  }
}
