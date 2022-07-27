import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final String? email;
  final String? password;
  const SignUpState({this.email, this.password});
  const SignUpState.initState() : this();

  SignUpState copyWith({
    String? email,
    String? password,
  }) {
    return SignUpState(email: email, password: password);
  }

  @override
  List<Object?> get props => [email, password];
}
