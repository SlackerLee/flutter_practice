import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<FetchUserEvent>(_onFetchUser);
    on<UpdateUserEvent>(_onUpdateUser);
  }

  Future<void> _onFetchUser(
    FetchUserEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(UserLoading());
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      emit(UserLoaded(
        name: 'John Doe',
        email: 'john.doe@example.com',
      ));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onUpdateUser(
    UpdateUserEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(UserLoading());
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      emit(UserLoaded(
        name: event.name,
        email: event.email,
      ));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
} 