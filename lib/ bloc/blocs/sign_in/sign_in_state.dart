import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override 
  List<Object?> get props => [];
}

class SignInInitial extends SignInState{}

class SignInLoading extends SignInState{}

class SigInded extends SignInState {
}

class SignInFaild extends SignInState{}