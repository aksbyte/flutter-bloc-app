import 'package:bloc_flutter_app/bloc/internet_bloc/internet_bloc.dart';
import 'package:bloc_flutter_app/cubit/internet_cubit.dart';
import 'package:bloc_flutter_app/firebase_options.dart';
import 'package:bloc_flutter_app/phone_auth/cubit/auth_cubit/auth_cubit.dart';
import 'package:bloc_flutter_app/screen/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(create: (context) => InternetCubit()),
        BlocProvider<InternetBloc>(create: (context) => InternetBloc()),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        home: HomePage(),
        /*BlocBuilder<AuthCubit, AuthState>(
          builder: (BuildContext context, state) {
            if (state is AuthLoggedInState) {
              return const AuthPage();
            } else if (state is AuthLoggedOutState) {
              return SignInPhoneNumberScreen();
            } else {
              return const HomePage();
            }
          },
        ),*/
        //SignInPhoneNumberScreen(),
      ),
    );
  }
}
