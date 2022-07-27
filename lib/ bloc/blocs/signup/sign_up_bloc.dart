import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/signup/sign_up_event.dart';
import 'package:whisky_hunter/%20bloc/blocs/signup/sign_up_state.dart';
import 'package:whisky_hunter/src/firebase/firebase_helper.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState.initState()) {
    on<GetEmailAndPasswordUEvent>(_onGetEmailAndPasswordFormTextField);
    on<CreatUserWithEmailAndPassword>(_onCreateNewAccount);
  }

  Future<void> _onGetEmailAndPasswordFormTextField(
      GetEmailAndPasswordUEvent event, Emitter<void> emitter) async {
    emitter(
      state.copyWith(
        email: event.email ?? state.email,
        password: event.password ?? state.password,
      ),
    );
  }

  Future<void> _onCreateNewAccount(
      CreatUserWithEmailAndPassword event, Emitter<void> emitter) async {
    await FirebaseHelper.firebaseHelper.creatUserWithEmailAndPassword(
      email: event.email ?? state.email,
      password: event.password ?? state.password,
    );
  }
}
