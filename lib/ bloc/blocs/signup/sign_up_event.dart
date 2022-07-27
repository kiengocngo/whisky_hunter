import 'package:equatable/equatable.dart';

class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetEmailAndPasswordUEvent extends SignUpEvent {
  final String? email;
  final String? password;
  GetEmailAndPasswordUEvent({this.email, this.password});
  @override
  List<Object?> get props => [email, password];
}

class CreatUserWithEmailAndPassword extends SignUpEvent {
  final String? email;
  final String? password;
  CreatUserWithEmailAndPassword({this.email, this.password});
  @override
  List<Object?> get props => [email, password];
}
