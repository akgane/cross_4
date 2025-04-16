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
    apiKey: 'AIzaSyDmUCbA3f3ZHBfuQvzbltvE2CjLMxlE1Vs',
    appId: '1:1035251943759:web:394a8f7fa844e22cdbdd3a',
    messagingSenderId: '1035251943759',
    projectId: 'cross-rentalestate',
    authDomain: 'cross-rentalestate.firebaseapp.com',
    storageBucket: 'cross-rentalestate.firebasestorage.app',
    measurementId: 'G-Y45Z9KM4ZH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBQSgl-e19_Dzi3gCn6QFIVuXpcXx9iaD4',
    appId: '1:1035251943759:android:9c49f7805bbf7a44dbdd3a',
    messagingSenderId: '1035251943759',
    projectId: 'cross-rentalestate',
    storageBucket: 'cross-rentalestate.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDUrPEhKtN62613VaD8be8lDb0GEztT4As',
    appId: '1:1035251943759:ios:a10a036976e6a878dbdd3a',
    messagingSenderId: '1035251943759',
    projectId: 'cross-rentalestate',
    storageBucket: 'cross-rentalestate.firebasestorage.app',
    iosBundleId: 'com.example.rental',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDUrPEhKtN62613VaD8be8lDb0GEztT4As',
    appId: '1:1035251943759:ios:a10a036976e6a878dbdd3a',
    messagingSenderId: '1035251943759',
    projectId: 'cross-rentalestate',
    storageBucket: 'cross-rentalestate.firebasestorage.app',
    iosBundleId: 'com.example.rental',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDmUCbA3f3ZHBfuQvzbltvE2CjLMxlE1Vs',
    appId: '1:1035251943759:web:93fd9ef641638e5edbdd3a',
    messagingSenderId: '1035251943759',
    projectId: 'cross-rentalestate',
    authDomain: 'cross-rentalestate.firebaseapp.com',
    storageBucket: 'cross-rentalestate.firebasestorage.app',
    measurementId: 'G-2XHL64KP65',
  );
}
