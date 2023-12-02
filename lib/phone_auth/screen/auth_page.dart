import 'package:bloc_flutter_app/phone_auth/cubit/auth_cubit/auth_cubit.dart';
import 'package:bloc_flutter_app/phone_auth/cubit/auth_cubit/auth_state.dart';
import 'package:bloc_flutter_app/phone_auth/screen/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Auth Page',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text('Hello Mob.....'),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              builder: (BuildContext context, state) {
                return CupertinoButton(
                    color: Colors.green,
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context).logOut();
                    },
                    child: const Text('Logout'));
              },
              listener: (BuildContext context, Object? state) {
                if(state is AuthLoggedOutState){
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPhoneNumberScreen(),));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
