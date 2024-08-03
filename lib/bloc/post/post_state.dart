import 'package:demo_revised_project/models/post/post.dart';
import 'package:equatable/equatable.dart';

class PostState extends Equatable {
  final bool isLoading;
  final bool isFailed;
  final List<Post>? data;
  final String? error;

  const PostState({
    required this.isLoading,
    required this.isFailed,
    this.data,
    this.error,
  });

  PostState.initial()
      : isLoading = false,
        isFailed = false,
        data = [],
        error = null;

  PostState copyWith({
    bool? isLoading,
    bool? isFailed,
    List<Post>? data,
    String? error,
  }) {
    return PostState(
      isLoading: isLoading ?? this.isLoading,
      isFailed: isFailed ?? this.isFailed,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isFailed, data, error];
}
