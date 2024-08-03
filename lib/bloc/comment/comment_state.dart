import 'package:demo_revised_project/models/post/comments.dart';
import 'package:equatable/equatable.dart';

class CommentsState extends Equatable {
  final bool isLoading;
  final bool isFailed;
  final List<Comments>? data;
  final String? error;
  final bool isCommentPosted;

  const CommentsState({
    required this.isLoading,
    required this.isFailed,
    this.data,
    this.error,
    this.isCommentPosted = false,
  });

  factory CommentsState.initial() {
    return const CommentsState(
      isLoading: false,
      isFailed: false,
      data: [],
    );
  }

  CommentsState copyWith({
    bool? isLoading,
    bool? isFailed,
    List<Comments>? data,
    String? error,
    bool? isCommentPosted,
  }) {
    return CommentsState(
      isLoading: isLoading ?? this.isLoading,
      isFailed: isFailed ?? this.isFailed,
      data: data ?? this.data,
      error: error ?? this.error,
      isCommentPosted: isCommentPosted ?? this.isCommentPosted,
    );
  }

  @override
  List<Object?> get props => [isLoading, isFailed, data, error];
}
