import 'package:demo_revised_project/models/albums/photos.dart';
import 'package:equatable/equatable.dart';

class PhotosState extends Equatable {
  final bool isLoading;
  final bool isFailed;
  final List<Photos>? data;
  final String? error;

  const PhotosState({
    required this.isLoading,
    required this.isFailed,
    this.data,
    this.error,
  });

  PhotosState.initial()
      : isLoading = false,
        isFailed = false,
        data = [],
        error = null;

  PhotosState copyWith({
    bool? isLoading,
    bool? isFailed,
    List<Photos>? data,
    String? error,
  }) {
    return PhotosState(
      isLoading: isLoading ?? this.isLoading,
      isFailed: isFailed ?? this.isFailed,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isFailed, data, error];
}
