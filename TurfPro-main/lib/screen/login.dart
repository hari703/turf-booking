import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; 
import 'package:turfpro/screen/admin_panel/admin_panel_section.dart';
import 'package:turfpro/screen/forgot_password.dart';
import 'package:turfpro/screen/home/homescreen.dart';
import 'package:turfpro/screen/manager_panel/manager_panel_screen.dart';
import 'package:turfpro/colors.dart'; 
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    String? accountType = prefs.getString('accountType');
    
    if (accountType != null) {
      _navigateToScreen(accountType);
    }
  }

  void _navigateToScreen(String accountType) {
    if (accountType == 'Admin') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AdminPanelScreen()),
        (route) => false,
      );
    } else if (accountType == 'Manager') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const ManagerPanelScreen()),
        (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    }
  }

  void _loginUser() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      
      await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
);

      final accountType = email == 'admin@example.com' ? 'Admin' : 'User';

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('accountType', accountType);
      await prefs.setString('email', email);
      _navigateToScreen(accountType);

    } on FirebaseAuthException catch (_) {
      await _checkHttpLogin();
    } catch (_) {
   setState(() {
     _errorMessage = 'Unexpected error occurred.';
     _isLoading = false;
   });
}
  }

  Future<void> _checkHttpLogin() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/user/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        String accountType = responseData['accountType'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accountType', accountType);
        _navigateToScreen(accountType);
      } else {
        setState(() {
          _errorMessage = 'Login failed: ${json.decode(response.body)['message']}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Unexpected error occurred: $e';
        _isLoading = false;
      });
    }
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accountType'); 
    await prefs.remove('email'); 
    
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.darkContainer : AppColors.lightContainer,
      appBar: AppBar(
        backgroundColor: isDarkMode ? AppColors.darkContainer : AppColors.lightContainer,
        title: const Text('Login'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout, 
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    'assests/images/logo.png', 
                    height: 150, 
                    width: 150,  
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome back! Please log in to continue.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: const OutlineInputBorder(),
                    hintText: 'Enter your email',
                    fillColor: isDarkMode ? AppColors.darkContainer : AppColors.lightContainer,
                    filled: true,
                    prefixIcon: const Icon(Icons.email, color: Colors.grey),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    hintText: 'Enter your password',
                    fillColor: isDarkMode ? AppColors.darkContainer : AppColors.lightContainer,
                    filled: true,
                    prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _isLoading ? null : _loginUser,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    backgroundColor: isDarkMode ? Colors.grey[700] : Colors.green,
                  ),
                  child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white) 
                    : const Text('Login', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 20),
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                    );
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
