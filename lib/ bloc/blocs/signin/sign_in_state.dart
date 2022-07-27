import 'package:equatable/equatable.dart';

class SignInState extends Equatable {
  final String? email;
  final String? password;
  const SignInState({
    this.email,
    this.password,
  });
  const SignInState.initState() : this();
  SignInState copyWith({
    String? email,
    String? password,
  }) {
    return SignInState(
      email: email,
      password: password,
    );
  }

  @override
  List<Object?> get props => [email, password];
}

class SignInLoadFailure extends SignInState {
  final dynamic error;
  const SignInLoadFailure(this.error);
}
