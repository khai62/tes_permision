import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  // meminta izin dan menampilkan alert
  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('User granted provisional permission');
      }
    } else {
      if (kDebugMode) {
        print('User denied permission');
      }
    }
  }

  //akhir ---------- meminta izin dan menampilkan alert
  Future<void> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      print('Location permission granted');
    } else if (status.isDenied) {
      print('Location permission denied');
    } else if (status.isPermanentlyDenied) {
      print(
          'Location permission permanently denied, open app settings to change');
      openAppSettings();
    }
  }

  Future<void> requestPhonePermission() async {
    PermissionStatus status = await Permission.phone.request();
    if (status.isGranted) {
      print('Phone permission granted');
    } else if (status.isDenied) {
      print('Phone permission denied');
    } else if (status.isPermanentlyDenied) {
      print('Phone permission permanently denied, open app settings to change');
      openAppSettings();
    }
  }
}
