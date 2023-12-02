import 'package:bloc_flutter_app/phone_auth/cubit/auth_cubit/auth_cubit.dart';
import 'package:bloc_flutter_app/phone_auth/cubit/auth_cubit/auth_state.dart';
import 'package:bloc_flutter_app/phone_auth/screen/auth_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyPhoneNumber extends StatelessWidget {
  VerifyPhoneNumber({super.key});

  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verify Phone Number',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: otpController,
              maxLength: 6,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '6-Digit OTP',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
              BlocConsumer<AuthCubit, AuthState>(
              builder: (BuildContext context, state) {
                if (state is AuthLoadingState) {
                  return const Center(child: CupertinoActivityIndicator());
                }
                return CupertinoButton(
                    color: Colors.grey,
                    child: const Text('Verify'),
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context)
                          .verifyOtp(otpController.text);
                    });
              },
              listener: (BuildContext context, Object? state) {
                if (state is AuthLoggedInState) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthPage(),
                      ));
                }else if(state is AuthErrorState){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red, content: Text(state.error)));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
