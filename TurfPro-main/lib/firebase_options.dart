
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCiufud6-iCWWLlOq9kvDLOsLS3G8OeXhU',
    appId: '1:133733183690:android:e7c0b3e756e6d284050433',
    messagingSenderId: '133733183690',
    projectId: 'book-ca3c6',
    authDomain: 'sentoffsquad.firebaseapp.com',
    storageBucket: 'book-ca3c6.firebasestorage',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCiufud6-iCWWLlOq9kvDLOsLS3G8OeXhU',
    appId: '1:859137929629:android:8820544e15e1f1622cbf74',
    messagingSenderId: '859137929629',
    projectId: 'sentoffsquad-11df3',
    storageBucket: 'sentoffsquad.appspot.com',
  );

}