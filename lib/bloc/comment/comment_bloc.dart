import 'package:demo_revised_project/bloc/comment/comment_event.dart';
import 'package:demo_revised_project/bloc/comment/comment_state.dart';
import 'package:demo_revised_project/models/post/comments.dart';
import 'package:demo_revised_project/repository/post_repository.dart';
import 'package:demo_revised_project/models/response/api_response_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final PostRepository _postRepository;

  CommentsBloc({required PostRepository postRepository})
      : _postRepository = postRepository,
        super(CommentsState.initial()) {
    on<FetchPostComments>(_onFetchPostComments);
    on<PostNewComment>(_onPostNewComment);
  }

  void _onFetchPostComments(
    FetchPostComments event,
    Emitter<CommentsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    await emit.forEach<ApiResponseStatus<List<Comments>>>(
      _postRepository.fetchUserPostCommentsList(event.postId),
      onData: (response) {
        if (response.isSuccessful) {
          return state.copyWith(
            isLoading: false,
            isFailed: false,
            data: response.data,
            error: response.error,
          );
        } else {
          return state.copyWith(
            isLoading: false,
            isFailed: true,
            error: response.error,
          );
        }
      },
      onError: (error, stackTrace) {
        return state.copyWith(
          isLoading: false,
          isFailed: true,
          error: error.toString(),
        );
      },
    );
  }

  void _onPostNewComment(
    PostNewComment event,
    Emitter<CommentsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final response =
          await _postRepository.postNewComment(event.postId, event.comment);
      if (response.isSuccessful) {
        emit(state.copyWith(
          isLoading: false,
          isFailed: false,
          isCommentPosted: true,
          error: null,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          isFailed: true,
          error: response.error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isFailed: true,
        error: e.toString(),
      ));
    }
  }
}
