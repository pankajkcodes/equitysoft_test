// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBxRxrbVXttushwEe61x_54nJROSWh11PE',
    appId: '1:1072505666168:web:5e803e6eac1ea6d0064b8d',
    messagingSenderId: '1072505666168',
    projectId: 'equitysoft-test-1',
    authDomain: 'equitysoft-test-1.firebaseapp.com',
    storageBucket: 'equitysoft-test-1.appspot.com',
    measurementId: 'G-E7R5WWQFVZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAwSeFVNIvQGdwZOfKA726XrSXUopdtEZ4',
    appId: '1:1072505666168:android:587a14a53d518adf064b8d',
    messagingSenderId: '1072505666168',
    projectId: 'equitysoft-test-1',
    storageBucket: 'equitysoft-test-1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDzQYRyANDXrgawoJ6CFhGs4ebXu-goaDo',
    appId: '1:1072505666168:ios:72dfe3cded20780c064b8d',
    messagingSenderId: '1072505666168',
    projectId: 'equitysoft-test-1',
    storageBucket: 'equitysoft-test-1.appspot.com',
    iosClientId: '1072505666168-ppb6p4qbknbc3n6cbdebogqjm4lt0a45.apps.googleusercontent.com',
    iosBundleId: 'com.pankajkcodes.equitysoftTest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDzQYRyANDXrgawoJ6CFhGs4ebXu-goaDo',
    appId: '1:1072505666168:ios:72dfe3cded20780c064b8d',
    messagingSenderId: '1072505666168',
    projectId: 'equitysoft-test-1',
    storageBucket: 'equitysoft-test-1.appspot.com',
    iosClientId: '1072505666168-ppb6p4qbknbc3n6cbdebogqjm4lt0a45.apps.googleusercontent.com',
    iosBundleId: 'com.pankajkcodes.equitysoftTest',
  );
}
