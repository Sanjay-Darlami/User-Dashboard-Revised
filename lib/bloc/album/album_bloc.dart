import 'package:demo_revised_project/bloc/album/album_event.dart';
import 'package:demo_revised_project/bloc/album/album_state.dart';
import 'package:demo_revised_project/models/albums/album.dart';
import 'package:demo_revised_project/repository/album_repository.dart';
import 'package:demo_revised_project/models/response/api_response_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository _albumRepository;

  AlbumBloc({
    required AlbumRepository albumRepository,
  })  : _albumRepository = albumRepository,
        super(AlbumState.initial()) {
    on<FetchUserAlbumsList>(_onFetchUserAlbumsList);
  }

  void _onFetchUserAlbumsList(
    FetchUserAlbumsList event,
    Emitter<AlbumState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    await emit.forEach<ApiResponseStatus<List<Album>>>(
      _albumRepository.fetchUserAlbumsList(event.userId),
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
}
