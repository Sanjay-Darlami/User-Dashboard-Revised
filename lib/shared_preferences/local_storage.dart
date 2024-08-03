import 'package:demo_revised_project/models/post/post.dart';

abstract class LocalDataSource {
  Future<void> cacheUserPosts(int userId, List<Post> posts);
  List<Post> retrieveCacheUserPosts(int userId);
  Future<void> clearCachedUserPosts(int userId);
}
