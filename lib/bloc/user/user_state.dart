import 'package:equatable/equatable.dart';
import 'package:demo_revised_project/models/user/user.dart';

class UserState extends Equatable {
  final bool isLoading;
  final bool isFailed;
  final List<User>? data;
  final String? error;

  const UserState({
    required this.isLoading,
    required this.isFailed,
    this.data,
    this.error,
  });

  UserState.initial()
      : isLoading = false,
        isFailed = false,
        data = [],
        error = null;

  UserState copyWith({
    bool? isLoading,
    bool? isFailed,
    List<User>? data,
    String? error,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      isFailed: isFailed ?? this.isFailed,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isFailed, data, error];
}
