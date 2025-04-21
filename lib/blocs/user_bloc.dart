import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info/models/company.dart';

import '../models/address.dart';
import '../models/geo.dart' as geo_model;
import '../models/user.dart';

// Events
abstract class UserEvent {}

class FetchUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final User user;
  UpdateUserEvent(this.user);
}

// States
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;
  UserLoaded(this.user);
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}

// Bloc
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
      
      // Simulate user data
      final user = User(
        id: 1,
        name: 'John Doe',
        username: 'johndoe',
        email: 'john@example.com',
        address: Address(
          street: '123 Main St',
          suite: 'Apt 4B',
          city: 'New York',
          zipcode: '10001',
          geo: geo_model.Geo(lat: '40.7128', lng: '-74.0060'),
        ),
        phone: '1-234-567-8900',
        website: 'www.example.com',
        company: Company(
          name: 'Example Corp',
          catchPhrase: 'Making the world better',
          bs: 'Innovation',
        ),
      );
      
      emit(UserLoaded(user));
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
      
      emit(UserLoaded(event.user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
} 