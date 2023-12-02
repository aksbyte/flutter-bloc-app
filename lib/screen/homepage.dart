import 'package:bloc_flutter_app/bloc/internet_bloc/internet_bloc.dart';
import 'package:bloc_flutter_app/bloc/internet_bloc/internet_state.dart';
import 'package:bloc_flutter_app/login_signup/bloc/sign_in_bloc.dart';
import 'package:bloc_flutter_app/login_signup/screen/signIn_screen.dart';
import 'package:bloc_flutter_app/phone_auth/screen/sign_in_screen.dart';
import 'package:bloc_flutter_app/screen/internet_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'B L O C ',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                color: Colors.green,
                child: const Text(
                  'This is BLoC using event state',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            BlocConsumer<InternetBloc, InternetState>(
              listener: (BuildContext context, state) {
                if (state is InternetGainedState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Center(
                          child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.online_prediction_sharp,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Connection is back! '),
                        ],
                      )),
                      backgroundColor: Colors.green[600],
                      duration: const Duration(seconds: 2),
                    ),
                  );
                } else if (state is InternetLostState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Center(
                        child: Row(
                          children: [
                            Icon(
                              Icons
                                  .signal_cellular_connected_no_internet_0_bar_sharp,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('You are offline!'),
                          ],
                        ),
                      ),
                      backgroundColor: Colors.red[600],
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              builder: (BuildContext context, Object? state) {
                if (state is InternetGainedState) {
                  return const Text('Connected....');
                } else if (state is InternetLostState) {
                  return const Text('Lost connection');
                } else {
                  return const Text('Loading....');
                }
              },
            ),
            const SizedBox(
              height: 100,
            ),
            CupertinoButton(
              color: Colors.grey,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InternetScreen(),
                    ));
              },
              child: const Text(
                'CUBIT PAGE',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            CupertinoButton(
              color: Colors.grey,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                          create: (BuildContext context) => SignInBloc(),
                          child: SignInScreen()),
                    ));
              },
              child: const Text(
                'LOGIN PAGE',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20,),
            CupertinoButton(
              color: Colors.grey,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInPhoneNumberScreen(),
                    ));
              },
              child: const Text(
                'Phone Auth Page',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        /* child: BlocBuilder<InternetBloc, InternetState>(
          builder: (BuildContext context, state) {
            if (state is InternetGainedState) {
              return const Text('Connected....');
            } else if (state is InternetLostState) {
              return const Text('Lost connection');
            } else {
              return const Text('Loading....');
            }
          },
        ),*/
      ),
    );
  }
}
