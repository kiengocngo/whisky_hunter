import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/sign_in/sign_in_event.dart';
import 'package:whisky_hunter/%20bloc/blocs/sign_in/sign_in_state.dart';
import 'package:whisky_hunter/resource/repository/api_repository_auction_info.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on((event, emit) async {
      try {
        emit(SignInLoading());
      } on NetWorkError {
        emit(SignInFaild());
      }
    });
  }
}
