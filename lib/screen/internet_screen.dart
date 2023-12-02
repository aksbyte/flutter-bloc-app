import 'package:bloc_flutter_app/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetScreen extends StatelessWidget {
  const InternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'B L O C CUBIT',
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
                'This is BLoC using Cubit state',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          BlocConsumer<InternetCubit, InternetState>(
            builder: (BuildContext context, state) {
              if (state == InternetState.gained) {
                return const Text('Connected...');
              } else if(state == InternetState.lost){
                return const Text('Waiting for connection...');
              }else {
                return const Text('Internet lost');
              }
            },
            listener: (BuildContext context, Object? state) {
              if (state == InternetState.gained) {
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

              } else if (state == InternetState.lost) {
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
          ),
        ],
      )),
    );
  }
}
