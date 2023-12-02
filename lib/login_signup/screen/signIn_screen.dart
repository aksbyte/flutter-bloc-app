import 'dart:async';

import 'package:bloc_flutter_app/login_signup/bloc/sign_in_bloc.dart';
import 'package:bloc_flutter_app/login_signup/bloc/sign_in_event.dart';
import 'package:bloc_flutter_app/login_signup/bloc/sign_in_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'SIGN IN SCREEN ',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 1,
          backgroundColor: Colors.green,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Center(child: Text('Sign in using event state in BLoC')),
              const SizedBox(
                height: 90,
              ),
              BlocBuilder<SignInBloc, SignInState>(
                builder: (BuildContext context, state) {
                  if (state is SignInErrorState) {
                    return Text(
                      state.errorMessage,
                      style: TextStyle(color: Colors.red[600]),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _emailController,
                onChanged: (val) {
                  BlocProvider.of<SignInBloc>(context).add(
                      SignInTextChangeEvent(
                          _emailController.text, _passwordController.text));
                },
                decoration: const InputDecoration(hintText: 'Email Address'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _passwordController,
                onChanged: (val) {
                  BlocProvider.of<SignInBloc>(context).add(
                    SignInTextChangeEvent(
                        _emailController.text, _passwordController.text),
                  );
                },
                decoration: const InputDecoration(hintText: 'Password'),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<SignInBloc, SignInState>(
                builder: (BuildContext context, SignInState state) {
                  if (state is SignInLoadingState) {
                    return const Center(
                      child: CupertinoActivityIndicator(
                        animating: true,
                      ),
                    );
                  }
                  return CupertinoButton(
                    onPressed: () {
                      if (state is SignInValidState) {
                        BlocProvider.of<SignInBloc>(context).add(
                          SignInSubmittedEvent(
                              _emailController.text, _passwordController.text),
                        );
                        Timer(const Duration(seconds: 3), () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DashBoard(
                                  email: _emailController.text.toString(),
                                ),
                              ));
                        });
                      }
                    },
                    color: (state is SignInValidState)
                        ? Colors.green
                        : Colors.grey,
                    child: const Text(
                      'Sign in',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
