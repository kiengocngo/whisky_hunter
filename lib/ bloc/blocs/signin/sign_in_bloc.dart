import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/signin/sign_in_event.dart';
import 'package:whisky_hunter/%20bloc/blocs/signin/sign_in_state.dart';
import 'package:whisky_hunter/src/firebase/firebase_helper.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInState.initState()) {
    on<GetEmailAndPasswordEvent>(_getEmailAndPassword);
    on<LoginEvent>((event, emit) async {
      try {
        await FirebaseHelper.firebaseHelper.signInWithEmailAndPassword(
          email: state.email,
          password: state.password,
        );
      }on FirebaseAuthException catch (e) {
        emit(SignInLoadFailure(e.message));
      }
    });
    on<SignOutEvent>(_signOut);
  }
  Future<void> _getEmailAndPassword(
      GetEmailAndPasswordEvent event, emit) async {
    emit(
      state.copyWith(
        email: event.email ?? state.email,
        password: event.password ?? state.password,
      ),
    );
  }

  Future<void> _signOut(SignOutEvent event, emit) async {
    await FirebaseHelper.firebaseHelper.signOut();
  }
}
