abstract class UserEvent {}

class FetchUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final String name;
  final String email;

  UpdateUserEvent({required this.name, required this.email});
} 