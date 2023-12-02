import 'package:bloc_flutter_app/login_signup/bloc/sign_in_event.dart';
import 'package:bloc_flutter_app/login_signup/bloc/sign_in_state.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitialState()) {
    on<SignInTextChangeEvent>((event, emit) {
      // Here event will include all data of this Function

      if (EmailValidator.validate(event.emailValue) == false) {
        emit(SignInErrorState('Please enter a valid email address'));
      } else if (event.passwordValue.length < 8) {
        emit(SignInErrorState('Please enter a valid password'));
      } else {
        emit(SignInValidState());
      }
    });
    on<SignInSubmittedEvent>((event, emit) {
      emit(SignInLoadingState());
    });
  }
}
