import 'package:bloc_flutter_app/phone_auth/cubit/auth_cubit/auth_cubit.dart';
import 'package:bloc_flutter_app/phone_auth/cubit/auth_cubit/auth_state.dart';
import 'package:bloc_flutter_app/phone_auth/screen/verify_phone_number.dart';
import 'package:bloc_flutter_app/screen/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPhoneNumberScreen extends StatelessWidget {
  SignInPhoneNumberScreen({super.key});

  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign In with Phone',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: phoneController,
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Phone Number',
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
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }
                return CupertinoButton(
                    color: Colors.grey,
                    child: const Text('Sign In'),
                    onPressed: () {
                      String phoneNumber = "+91${phoneController.text}";
                      BlocProvider.of<AuthCubit>(context).sendOtp(phoneNumber);
                    });
              },
              listener: (BuildContext context, Object? state) {
                if (state is AuthCodeSendState) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerifyPhoneNumber(),
                      ));
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
              color: Colors.green,
                child: const Text('Homepage'),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                })
          ],
        ),
      ),
    );
  }
}
