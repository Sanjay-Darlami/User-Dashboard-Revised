import 'package:equatable/equatable.dart';

abstract class AlbumEvent extends Equatable {
  const AlbumEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserAlbumsList extends AlbumEvent {
  final int userId;

  const FetchUserAlbumsList(this.userId);

  @override
  List<Object?> get props => [userId];
}
