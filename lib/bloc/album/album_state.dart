import 'package:demo_revised_project/models/albums/album.dart';
import 'package:equatable/equatable.dart';

class AlbumState extends Equatable {
  final bool isLoading;
  final bool isFailed;
  final List<Album>? data;
  final String? error;

  const AlbumState({
    required this.isLoading,
    required this.isFailed,
    this.data,
    this.error,
  });

  AlbumState.initial()
      : isLoading = false,
        isFailed = false,
        data = [],
        error = null;

  AlbumState copyWith({
    bool? isLoading,
    bool? isFailed,
    List<Album>? data,
    String? error,
  }) {
    return AlbumState(
      isLoading: isLoading ?? this.isLoading,
      isFailed: isFailed ?? this.isFailed,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isFailed, data, error];
}
