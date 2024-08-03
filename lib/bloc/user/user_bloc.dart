import 'package:demo_revised_project/bloc/user/user_event.dart';
import 'package:demo_revised_project/bloc/user/user_state.dart';
import 'package:demo_revised_project/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(UserState.initial()) {
    on<FetchUserList>(_onFetchUserList);
  }

  void _onFetchUserList(
    FetchUserList event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final response = await _userRepository.fetchUserList();

      if (response.isSuccessful) {
        emit(state.copyWith(
          isLoading: false,
          isFailed: false,
          data: response.data,
          error: response.error,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          isFailed: true,
          error: response.error,
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        isFailed: true,
        error: error.toString(),
      ));
    }

    // await emit.forEach<ApiResponseStatus<List<User>>>(
    //   _userRepository.fetchUserList(),
    //   onData: (response) {
    //     if (response.isSuccessful) {
    //       return state.copyWith(
    //         isLoading: false,
    //         isFailed: false,
    //         data: response.data,
    //         error: response.error,
    //       );
    //     } else {
    //       return state.copyWith(
    //         isLoading: false,
    //         isFailed: true,
    //         error: response.error,
    //       );
    //     }
    //   },
    //   onError: (error, stackTrace) {
    //     return state.copyWith(
    //       isLoading: false,
    //       isFailed: true,
    //       error: error.toString(),
    //     );
    //   },
    // );
  }
}
