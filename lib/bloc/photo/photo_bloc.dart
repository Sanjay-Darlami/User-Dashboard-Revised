import 'package:demo_revised_project/bloc/photo/photo_event.dart';
import 'package:demo_revised_project/bloc/photo/photo_state.dart';
import 'package:demo_revised_project/models/albums/photos.dart';
import 'package:demo_revised_project/models/response/api_response_status.dart';
import 'package:demo_revised_project/repository/photo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotosState> {
  final PhotoRepository _photoRepository;

  PhotoBloc({
    required PhotoRepository photoRepository,
  })  : _photoRepository = photoRepository,
        super(PhotosState.initial()) {
    on<FetchUserPhotosList>(_onFetchUserPhotosList);
  }

  void _onFetchUserPhotosList(
      FetchUserPhotosList event, Emitter<PhotosState> emit) async {
    emit(state.copyWith(isLoading: true));

    await emit.forEach<ApiResponseStatus<List<Photos>>>(
      _photoRepository.fetchUserPhotosList(event.albumId),
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
