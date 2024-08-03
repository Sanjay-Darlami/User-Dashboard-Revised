import 'package:demo_revised_project/models/albums/album.dart';
import 'package:demo_revised_project/models/response/api_response_status.dart';
import 'package:demo_revised_project/network/url.dart';
import 'package:dio/dio.dart';

class AlbumRepository {
  final Dio _dio;

  AlbumRepository({required Dio dio}) : _dio = dio;

  Stream<ApiResponseStatus<List<Album>>> fetchUserAlbumsList(
      int userId) async* {
    List<Album>? albums;
    try {
      final response = await _dio.get("$usersUrl/$userId/albums");
      albums = (response.data as List<dynamic>).map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Album.fromJson(map);
      }).toList();

      yield ApiResponseStatus(
        isSuccessful: true,
        data: albums,
        error: null,
        fromLocal: false,
      );
    } on DioException catch (error) {
      yield ApiResponseStatus(
        isSuccessful: false,
        data: albums,
        error: error.message,
      );
    } catch (e) {
      yield ApiResponseStatus(
        isSuccessful: false,
        data: albums,
        error: e.toString(),
      );
    }
  }
}
