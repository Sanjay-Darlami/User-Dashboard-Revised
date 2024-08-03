import 'package:equatable/equatable.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object?> get props => [];
}

class FetchPostComments extends CommentsEvent {
  final int postId;

  const FetchPostComments(this.postId);

  @override
  List<Object?> get props => [postId];
}

class PostNewComment extends CommentsEvent {
  final int postId;
  final Map<String, dynamic> comment;
  const PostNewComment(this.postId, this.comment);
}
