import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserPostsList extends PostEvent {
  final int userId;

  const FetchUserPostsList(this.userId);

  @override
  List<Object?> get props => [userId];
}

class ClearCachedPosts extends PostEvent {
  final int userId;

  const ClearCachedPosts({required this.userId});
}
