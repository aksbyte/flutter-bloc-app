import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  final String email;
  const DashBoard({super.key, required this.email});

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
      body: Center(
        child: Text('Hello $email'),
      ),
    );
  }
}
