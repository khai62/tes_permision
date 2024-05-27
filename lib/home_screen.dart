import 'package:flutter/material.dart';
import 'package:tes/pustaka.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationService notificationServices = NotificationService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextButton(
              onPressed: notificationServices.requestLocationPermission,
              child: const Text('izinkan notifikai'),
            ),
          )
        ],
      ),
    );
  }
}
