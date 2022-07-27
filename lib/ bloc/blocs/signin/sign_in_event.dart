import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();
  @override
  List<Object?> get props => [];
}

class GetEmailAndPasswordEvent extends SignInEvent {
  final String? email;
  final String? password;
  const GetEmailAndPasswordEvent({
    this.email,
    this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class LoginEvent extends SignInEvent {}

class SignOutEvent extends SignInEvent {}
