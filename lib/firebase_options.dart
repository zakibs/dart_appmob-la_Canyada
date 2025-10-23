import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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

  // Configuration pour le web - À MODIFIER
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "votre",
    appId: "votre",
    messagingSenderId: "votre",
    projectId: "chicken-la-canyada",
    authDomain: "votre",
    storageBucket: "votre",
  );

  // Configuration pour Android - À MODIFIER
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "votre",
    appId: "votre",
    messagingSenderId: "votre",
    projectId: "chicken-la-canyada",
    storageBucket: "votre",
  );

  // Configuration pour iOS - À MODIFIER
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "votre",
    appId: "votre",
    messagingSenderId: "votre",
    projectId: "chicken-la-canyada",
    storageBucket: "votre,
    iosBundleId: "com.example.chickenLaCanyada",
  );

  // Configuration pour macOS - À MODIFIER
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "votre",
    appId: "1:123456789012:ios:aaaaaaaaaaaaaaaaaaaaaa",
    messagingSenderId: "votre",
    projectId: "chicken-la-canyada",
    storageBucket: "votre",
    iosBundleId: "com.example.chickenLaCanyada",
  );

  // Configuration pour Windows - À MODIFIER
  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: "votre",
    appId: "votre",
    messagingSenderId: "votre",
    projectId: "chicken-la-canyada",
    authDomain: "votre",
    storageBucket: "chicken-la-canyada.appspot.com",
  );
}
