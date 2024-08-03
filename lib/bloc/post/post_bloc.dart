import 'package:demo_revised_project/bloc/post/post_event.dart';
import 'package:demo_revised_project/bloc/post/post_state.dart';
import 'package:demo_revised_project/models/post/post.dart';
import 'package:demo_revised_project/repository/post_repository.dart';
import 'package:demo_revised_project/models/response/api_response_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;

  PostBloc({
    required PostRepository postRepository,
  })  : _postRepository = postRepository,
        super(PostState.initial()) {
    on<FetchUserPostsList>(_onFetchUserPostsList);
    on<ClearCachedPosts>(_onClearCacheEvent);
  }

  void _onFetchUserPostsList(
    FetchUserPostsList event,
    Emitter<PostState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    await emit.forEach<ApiResponseStatus<List<Post>>>(
      _postRepository.fetchUserPostsList(event.userId),
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

  void _onClearCacheEvent(
    ClearCachedPosts event,
    Emitter<PostState> emit,
  ) async {
    try {
      await _postRepository.clearCachedUserPosts(event.userId);
      emit(state.copyWith(
        isFailed: false,
        error: null,
        data: [],
      ));
    } catch (e) {
      emit(state.copyWith(
        isFailed: true,
        error: e.toString(),
      ));
    }
  }
}
