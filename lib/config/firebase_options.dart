import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
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
    apiKey: 'AIzaSyAAzcCf_Yzz9vqXuIHRDD_Awk8nOBwXmP0',
    appId: '1:508361698170:web:e1f491b4e323b1aafdc4c3',
    messagingSenderId: '508361698170',
    projectId: 'workingauth',
    authDomain: 'workingauth.firebaseapp.com',
    storageBucket: 'workingauth.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
      apiKey: 'AIzaSyB3Edk8CRvh0NIOYIH47uLiXkLogV-tO7c',
      appId: '1:508361698170:android:1cf4dfd46508c4befdc4c3',
      messagingSenderId: '508361698170',
      projectId: 'workingauth',
      storageBucket: 'workingauth.appspot.com',
      androidClientId:
          '508361698170-n364a6flon11fddjhvfk7qjsfi6ma3cc.apps.googleusercontent.com');

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC2FqR57uU1MdSIFXroY9Uyb5_8QT-3X-A',
    appId: '1:508361698170:ios:9eca20394e31a686fdc4c3',
    messagingSenderId: '508361698170',
    projectId: 'workingauth',
    storageBucket: 'workingauth.appspot.com',
    iosClientId:
        '508361698170-8j52mr3vo96ig7fndc7jq2ukokd8df0f.apps.googleusercontent.com',
    iosBundleId: 'com.example.workingauth',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC2FqR57uU1MdSIFXroY9Uyb5_8QT-3X-A',
    appId: '1:508361698170:ios:9eca20394e31a686fdc4c3',
    messagingSenderId: '508361698170',
    projectId: 'workingauth',
    storageBucket: 'workingauth.appspot.com',
    iosClientId:
        '508361698170-8j52mr3vo96ig7fndc7jq2ukokd8df0f.apps.googleusercontent.com',
    iosBundleId: 'com.example.workingauth',
  );
}
