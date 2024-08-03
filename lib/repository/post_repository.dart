import 'package:demo_revised_project/models/post/comments.dart';
import 'package:demo_revised_project/models/post/post.dart';
import 'package:demo_revised_project/models/response/comment_response.dart';
import 'package:demo_revised_project/network/url.dart';
import 'package:demo_revised_project/models/response/api_response_status.dart';
import 'package:demo_revised_project/shared_preferences/local_storage.dart';
import 'package:dio/dio.dart';

class PostRepository {
  final Dio _dio;
  final LocalDataSource _localDataStorage;

  PostRepository({required Dio dio, required LocalDataSource localDataStorage})
      : _dio = dio,
        _localDataStorage = localDataStorage;

  Stream<ApiResponseStatus<List<Post>>> fetchUserPostsList(int userId) async* {
    List<Post>? posts;
    try {
      posts = _localDataStorage.retrieveCacheUserPosts(userId);

      if (posts.isNotEmpty) {
        yield ApiResponseStatus(
          isSuccessful: true,
          data: posts,
          error: null,
          fromLocal: true,
        );
      } else {
        final response = await _dio.get("$usersUrl/$userId/posts");
        posts = (response.data as List<dynamic>).map((dynamic json) {
          final map = json as Map<String, dynamic>;
          return Post.fromJson(map);
        }).toList();

        await _localDataStorage.cacheUserPosts(userId, posts);

        yield ApiResponseStatus(
          isSuccessful: true,
          data: posts,
          error: null,
          fromLocal: false,
        );
      }
    } on DioException catch (error) {
      yield ApiResponseStatus(
        isSuccessful: false,
        data: posts,
        error: error.message,
      );
    } catch (e) {
      yield ApiResponseStatus(
        isSuccessful: false,
        data: posts,
        error: e.toString(),
      );
    }
  }

  Future<void> clearCachedUserPosts(int userId) async {
    await _localDataStorage.clearCachedUserPosts(userId);
  }

  Stream<ApiResponseStatus<List<Comments>>> fetchUserPostCommentsList(
      int postId) async* {
    List<Comments>? comments;

    try {
      final response = await _dio.get("$postsUrl/$postId/comments");
      comments = (response.data as List<dynamic>).map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Comments.fromJson(map);
      }).toList();

      yield ApiResponseStatus(
        isSuccessful: true,
        data: comments,
        error: null,
        fromLocal: false,
      );
    } on DioException catch (error) {
      yield ApiResponseStatus(
        isSuccessful: false,
        data: comments,
        error: error.message,
      );
    } catch (e) {
      yield ApiResponseStatus(
        isSuccessful: false,
        data: comments,
        error: e.toString(),
      );
    }
  }

  Future<ApiResponseStatus<CommentResponse>> postNewComment(
      int postId, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        "https://jsonplaceholder.typicode.com/posts//$postId/comments",
        data: data,
      );

      final newComment = CommentResponse.fromJson(response.data);
      return ApiResponseStatus(
        isSuccessful: true,
        data: newComment,
        error: null,
        fromLocal: false,
      );
    } on DioException catch (error) {
      return ApiResponseStatus(
        isSuccessful: false,
        data: null,
        error: error.message,
      );
    } catch (e) {
      return ApiResponseStatus(
        isSuccessful: false,
        data: null,
        error: e.toString(),
      );
    }
  }
}
