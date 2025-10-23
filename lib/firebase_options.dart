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
    apiKey: "AIzaSyBGzx8au02AfiWDqUf11FOEs3QcddW2LpM",
    appId: "1:954033691907:web:f82bd15ab42a4e970d9d36",
    messagingSenderId: "954033691907",
    projectId: "chicken-la-canyada",
    authDomain: "chicken-la-canyada.firebaseapp.com",
    storageBucket: "chicken-la-canyada.firebasestorage.app",
  );

  // Configuration pour Android - À MODIFIER
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    appId: "1:123456789012:android:aaaaaaaaaaaaaaaaaaaaaa",
    messagingSenderId: "123456789012",
    projectId: "chicken-la-canyada",
    storageBucket: "chicken-la-canyada.appspot.com",
  );

  // Configuration pour iOS - À MODIFIER
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    appId: "1:123456789012:ios:aaaaaaaaaaaaaaaaaaaaaa",
    messagingSenderId: "123456789012",
    projectId: "chicken-la-canyada",
    storageBucket: "chicken-la-canyada.appspot.com",
    iosBundleId: "com.example.chickenLaCanyada",
  );

  // Configuration pour macOS - À MODIFIER
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "AIzaSyAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    appId: "1:123456789012:ios:aaaaaaaaaaaaaaaaaaaaaa",
    messagingSenderId: "123456789012",
    projectId: "chicken-la-canyada",
    storageBucket: "chicken-la-canyada.appspot.com",
    iosBundleId: "com.example.chickenLaCanyada",
  );

  // Configuration pour Windows - À MODIFIER
  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: "AIzaSyAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    appId: "1:123456789012:windows:aaaaaaaaaaaaaaaaaaaaaa",
    messagingSenderId: "123456789012",
    projectId: "chicken-la-canyada",
    authDomain: "chicken-la-canyada.firebaseapp.com",
    storageBucket: "chicken-la-canyada.appspot.com",
  );
}
