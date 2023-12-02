import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {} // For define type of state

// Now define all state here ie. all type of function or type of event you need

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthCodeSendState extends AuthState {}

class AuthCodeVerifyState extends AuthState {}

class AuthLoggedInState extends AuthState {
  final User firebaseUser;
  AuthLoggedInState(this.firebaseUser);
}

class AuthLoggedOutState extends AuthState {}

class AuthErrorState extends AuthState {
  final String error;

  AuthErrorState(this.error);
}
