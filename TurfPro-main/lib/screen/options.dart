import 'dart:async';
import 'package:flutter/material.dart';
import 'package:turfpro/colors.dart';
import 'package:turfpro/screen/login.dart';
import 'package:turfpro/screen/signup.dart';
import 'package:turfpro/header.dart'; 

class OptionScreen extends StatefulWidget {
  const OptionScreen({super.key});

  @override
  OptionScreenState createState() => OptionScreenState();
}

class OptionScreenState extends State<OptionScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<List<String>> _texts = [
    [
      'Easy Booking',
      'Book sports turf time slots with just a few taps.',
      'No more waiting or hassles.',
    ],
    [
      'Convenient Payments',
      'Pay for your bookings easily using methods like',
      'online payments or cash.',
    ],
    [
      'Exclusive Offers',
      'Get access to exclusive offers and discounts',
      'on sports turf bookings.',
    ]
  ];

  @override
  void dispose() {
    _stopAutoScroll();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (_pageController.hasClients) {
        setState(() {
          _currentPage = (_currentPage + 1) % _texts.length;
        });
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _stopAutoScroll() {
    _timer?.cancel();
    _timer = null;
  }
  void onSignupPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignupScreen()),
    );
  }

  void onLoginPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );

  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const HeaderWidget(), 
            const SizedBox(height: 20),
            SizedBox(
              height: 350,
              width: 300,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  Image.asset(
                    'assests/images/mob.png',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assests/images/Not.png',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assests/images/Pay.png',
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: _texts[_currentPage].map((text) {
                return Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? AppColors.darkOnSurface : AppColors.lightOnSurface,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_texts.length, (index) {
                return GestureDetector(
                  onTap: () {
                    _stopAutoScroll();
                    if (_pageController.hasClients) {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      setState(() {
                        _currentPage = index;
                      });
                      _startAutoScroll();
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: _currentPage == index ? 15 : 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index
                          ? (isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary)
                          : Colors.grey.withOpacity(0.5),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: onSignupPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary,
              ),
              child: const Text(
                "Let's get started",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onLoginPressed,
              style: ElevatedButton.styleFrom(
                foregroundColor: isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary,
              ),
              child: Text(
                "I already have an account",
                style: TextStyle(
                  color: isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
