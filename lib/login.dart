import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await preferences.setBool('loginShown', true);
            Navigator.pushReplacementNamed(context, 'homepage');
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
