import 'package:bloc_flutter_app/phone_auth/cubit/auth_cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  AuthCubit() : super(AuthInitialState()) {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      emit(AuthLoggedInState(currentUser));
    } else {
      emit(AuthLoggedOutState());
    }
  }

  void sendOtp(String phoneNumber) async {
    emit(AuthLoadingState());
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        codeSent: (verificationId, forceResendingToken) {
          _verificationId = verificationId;
          emit(AuthCodeSendState());
        },
        verificationCompleted: (phoneAuthCredential) {
          signInWithPhone(phoneAuthCredential);
        },
        verificationFailed: (error) {
          emit(AuthErrorState(error.message.toString()));
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _verificationId = _verificationId;
        });
  }

  void verifyOtp(String otp) async {
    emit(AuthLoadingState());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otp);
    signInWithPhone(credential);
  }

  void signInWithPhone(PhoneAuthCredential credential) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        emit(AuthLoggedInState(userCredential.user!));
      }
    } on FirebaseAuthException catch (error) {
      emit(AuthErrorState(error.message.toString()));
    }
  }
  void logOut() async{
    await _auth.signOut();
    emit(AuthLoggedOutState());
  }
}
