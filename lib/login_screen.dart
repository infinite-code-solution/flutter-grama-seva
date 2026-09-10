import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart'; // Adjust if HomeScreen is located elsewhere

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LocalAuthentication _auth = LocalAuthentication();

  final String _hardcodedEmail = "test@example.com";
  final String _hardcodedPassword = "password123";
  
  bool _hasLoggedInBefore = false;

  @override
  void initState() {
    super.initState();
    _checkFirstLogin();
  }

  Future<void> _checkFirstLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _hasLoggedInBefore = prefs.getBool('hasLoggedInBefore') ?? false;
    });
  }

  // Attempt login with Email & Password
  Future<void> _loginWithEmail() async {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      // Save that user has logged in before, so next time biometrics show up
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasLoggedInBefore', true);
      
      _navigateToHome();
    } else {
      _showError("Please enter an email and password!");
    }
  }

  // Attempt login with Biometrics
  Future<void> _loginWithBiometrics() async {
    try {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final bool canAuthenticate = await _auth.isDeviceSupported();

      if (!canAuthenticate && !canAuthenticateWithBiometrics) {
        _showError("Your device does not support biometrics or has none enrolled.");
        return;
      }

      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Please authenticate to log in',
      );

      if (didAuthenticate) {
        _navigateToHome();
      } else {
        _showError("Fingerprint authentication canceled or failed.");
      }
    } on PlatformException catch (e) {
      _showError("System Error: ${e.code} - ${e.message}");
    } catch (e) {
      _showError("Unknown Error: $e");
    }
  }

  void _navigateToHome() {
    // Navigate to HomeScreen and remove all previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_outline, size: 80, color: Colors.blue),
                const SizedBox(height: 32),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _loginWithEmail,
                    child: const Text("Login", style: TextStyle(fontSize: 18)),
                  ),
                ),
                if (_hasLoggedInBefore) ...[
                  const SizedBox(height: 24),
                  const Text("OR", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: _loginWithBiometrics,
                      icon: const Icon(Icons.fingerprint, size: 28),
                      label: const Text(
                        "Login with Biometrics",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
