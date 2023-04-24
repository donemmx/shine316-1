import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_theme_provider/flutter_theme_provider.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:shineradio/screens/home_page.dart';
import 'package:shineradio/screens/welcome.dart';

import 'navigation_bar.dart';
import 'widget/clip.dart';

void main() {
  // await JustAudioBackground.init(
  //   androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
  //   androidNotificationChannelName: 'Audio playback',
  //   androidNotificationOngoing: true,
  // );
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(MyApp());
}

Future<void> init() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyB-AZWZmoKvXIqtLVDo12VfEHDI8vOgHS4',
          appId: '1:683219982254:web:4cfa7d8bc868617364da3f',
          messagingSenderId: '683219982254',
          projectId: 'shine316-98826'));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  //await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.light;
    print('the device mode is $isDarkMode');
    return Container(
      child: Builder(builder: (context) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'shine radio',
          theme: lightTheme,
          home: WelcomeScreen(),
        );
      }),
    );
  }

  final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: Color.fromARGB(255, 241, 125, 125),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
  );

  final lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
  );
}
