part of 'bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateNameEvent extends LoginEvent {
  final String name;
  UpdateNameEvent(this.name);

  @override
  List<Object?> get props => [name];
}

class UpdateLastNameEvent extends LoginEvent {
  final String lastName;
  UpdateLastNameEvent(this.lastName);

  @override
  List<Object?> get props => [lastName];
}

class LoginSubmittedEvent extends LoginEvent {
  LoginSubmittedEvent();
}
