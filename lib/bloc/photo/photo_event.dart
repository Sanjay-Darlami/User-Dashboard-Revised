import 'package:equatable/equatable.dart';

abstract class PhotoEvent extends Equatable {
  const PhotoEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserPhotosList extends PhotoEvent {
  final int albumId;

  const FetchUserPhotosList(this.albumId);

  @override
  List<Object?> get props => [albumId];
}
