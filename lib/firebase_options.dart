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
    apiKey: 'AIzaSyDhaPIHDP-V7Mtep_kVJJlm-gJbSwNQ_Fw',
    appId: '1:762585533377:web:bfe359d9fc17d948b0bd40',
    messagingSenderId: '762585533377',
    projectId: 'halllaq',
    authDomain: 'halllaq.firebaseapp.com',
    storageBucket: 'halllaq.appspot.com',
    measurementId: 'G-HY14WCWQEK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBE1BLT0kzIJ9wnqTI8u4N4vYI41u9WGsc',
    appId: '1:762585533377:android:6e1fb567674aaf92b0bd40',
    messagingSenderId: '762585533377',
    projectId: 'halllaq',
    storageBucket: 'halllaq.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAg492zuoBn7Dbv4bGlHQO_YuFBJJiuTrc',
    appId: '1:762585533377:ios:7933041e10ae3250b0bd40',
    messagingSenderId: '762585533377',
    projectId: 'halllaq',
    storageBucket: 'halllaq.appspot.com',
    androidClientId: '762585533377-5r8bsnd63shhupfg868f3mjkba2t2eee.apps.googleusercontent.com',
    iosClientId: '762585533377-o23040gb34142f1oh6kodvjedmog5ij9.apps.googleusercontent.com',
    iosBundleId: 'com.user.networkUpp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAg492zuoBn7Dbv4bGlHQO_YuFBJJiuTrc',
    appId: '1:762585533377:ios:7933041e10ae3250b0bd40',
    messagingSenderId: '762585533377',
    projectId: 'halllaq',
    storageBucket: 'halllaq.appspot.com',
    androidClientId: '762585533377-5r8bsnd63shhupfg868f3mjkba2t2eee.apps.googleusercontent.com',
    iosClientId: '762585533377-o23040gb34142f1oh6kodvjedmog5ij9.apps.googleusercontent.com',
    iosBundleId: 'com.user.networkUpp',
  );
}