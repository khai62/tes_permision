import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await preferences.setBool('onboardingShown', true);
            Navigator.pushReplacementNamed(context, 'login');
          },
          child: const Text('Complete Onboarding'),
        ),
      ),
    );
  }
}
