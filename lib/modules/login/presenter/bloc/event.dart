part of 'bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateNameEvent extends LoginEvent {
  final String name;
  UpdateNameEvent(this.name);
}

class UpdateLastNameEvent extends LoginEvent {
  final String lastName;
  UpdateLastNameEvent(this.lastName);
}

class LoginSubmittedEvent extends LoginEvent {
  LoginSubmittedEvent();
}
