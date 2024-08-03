import 'dart:convert';

import 'package:demo_revised_project/models/post/post.dart';
import 'package:demo_revised_project/shared_preferences/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStorage implements LocalDataSource {
  final SharedPreferences _prefs;

  DataStorage({required SharedPreferences prefs}) : _prefs = prefs;

  @override
  Future<void> cacheUserPosts(int userId, List<Post> posts) async {
    final postsJson = jsonEncode(posts.map((post) => post.toJson()).toList());
    await _prefs.setString(userId.toString(), postsJson);
  }

  @override
  Future<void> clearCachedUserPosts(int userId) async {
    await _prefs.remove(userId.toString());
  }

  @override
  List<Post> retrieveCacheUserPosts(int userId) {
    final postsJson = _prefs.getString(userId.toString());
    if (postsJson == null) {
      return [];
    }
    final List<dynamic> decodedPosts = jsonDecode(postsJson);
    return decodedPosts.map((json) => Post.fromJson(json)).toList();
  }
}
