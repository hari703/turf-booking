import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:turfpro/screen/admin_panel/admin_panel_section.dart';
import 'package:turfpro/screen/game/game.dart';
import 'package:turfpro/screen/more/more.dart';
import 'package:turfpro/screen/notification.dart';
import 'package:turfpro/screen/options.dart';
import 'package:turfpro/screen/pageload.dart';
import 'package:turfpro/screen/ready.dart';
import 'package:turfpro/screen/sportspreference.dart';
import 'package:turfpro/screen/home/homescreen.dart';
import 'package:turfpro/screen/more/settings.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Use your Firebase options
  ); 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TurfPro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const LoadingWidget(
        backgroundTask: _loadData,
        myPage: HomeOrOptionsScreen(), 
      ),
      routes: {
        '/sports_preferences': (context) => const SportsPreferencesScreen(),
        '/notification_preferences': (context) => const NotificationPreferencesScreen(),
        '/ready': (context) => const ReadyScreen(),
        '/more': (context) => const MoreScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/games': (context) => const Sports(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

Future<void> _loadData() async {
  await Future.delayed(const Duration(seconds: 2));
}

class HomeOrOptionsScreen extends StatelessWidget {
  const HomeOrOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _determineHomePage(),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading page'));
        } else {
          return snapshot.data ?? const OptionScreen(); 
        }
      },
    );
  }

  Future<Widget> _determineHomePage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final bool isAdmin = prefs.getBool('isAdmin') ?? false;

    if (isLoggedIn) {
      if (isAdmin) {
        return const AdminPanelScreen(); 
      } else {
        return const HomeScreen(); 
      }
    } else {
      return const OptionScreen();
    }
  }
}
