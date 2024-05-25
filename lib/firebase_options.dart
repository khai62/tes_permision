// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCPzdLEgGb4ZeGFLakMTD5u2CLSfxDZU4k',
    appId: '1:337172269892:web:7b11562afdd55b00d36511',
    messagingSenderId: '337172269892',
    projectId: 'untuktesflutter',
    authDomain: 'untuktesflutter.firebaseapp.com',
    storageBucket: 'untuktesflutter.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD2l4X7pfqbtYTE4Mz9AXUhFTp9k0Kh_EQ',
    appId: '1:337172269892:android:71a01b718b59b88ad36511',
    messagingSenderId: '337172269892',
    projectId: 'untuktesflutter',
    storageBucket: 'untuktesflutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCfzhEEZmicBiMCjryPBZRxtTFWQuUu0rw',
    appId: '1:337172269892:ios:cf34460359a84056d36511',
    messagingSenderId: '337172269892',
    projectId: 'untuktesflutter',
    storageBucket: 'untuktesflutter.appspot.com',
    iosBundleId: 'com.example.tes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCfzhEEZmicBiMCjryPBZRxtTFWQuUu0rw',
    appId: '1:337172269892:ios:cf34460359a84056d36511',
    messagingSenderId: '337172269892',
    projectId: 'untuktesflutter',
    storageBucket: 'untuktesflutter.appspot.com',
    iosBundleId: 'com.example.tes',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCPzdLEgGb4ZeGFLakMTD5u2CLSfxDZU4k',
    appId: '1:337172269892:web:13b98d7ac1846888d36511',
    messagingSenderId: '337172269892',
    projectId: 'untuktesflutter',
    authDomain: 'untuktesflutter.firebaseapp.com',
    storageBucket: 'untuktesflutter.appspot.com',
  );
}
