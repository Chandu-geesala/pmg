import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthSignInRequested extends AuthEvent {
  final String email;
  final String password;

  AuthSignInRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthForgotPasswordRequested extends AuthEvent {
  final String email;

  AuthForgotPasswordRequested({required this.email});

  @override
  List<Object> get props => [email];
}

class AuthSignOutRequested extends AuthEvent {}
