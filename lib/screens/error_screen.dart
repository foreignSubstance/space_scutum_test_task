import 'package:flutter/material.dart';
import 'package:space_scutum_test_task/screens/home_screen.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  void returnToHomeScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
      return const HomeScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Oops, something went wrong',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            Image.asset('assets/error.gif'),
            TextButton(
              onPressed: () {
                returnToHomeScreen(context);
              },
              child: const Text(
                'Return and try again',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
