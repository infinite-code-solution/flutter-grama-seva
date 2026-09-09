import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'home_screen.dart';
import 'dart:async';
import 'network_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _checkInternetAndStartTimer();
  }

  void _checkInternetAndStartTimer() async {
    bool isConnected = await NetworkUtils.checkInternetConnection();
    if (!mounted) return;
    
    if (!isConnected) {
      _showNoInternetDialog();
      return;
    }

    bool isVpn = await NetworkUtils.isVpnActive();
    if (!mounted) return;

    if (isVpn) {
      _showVpnDialog();
      return;
    }

    // Cancel existing timer if any
    _timer?.cancel();

    // Simulate loading progress
    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        if (_progress >= 1.0) {
          timer.cancel();
          _navigateToHome();
        } else {
          _progress += 0.02; // Increase progress
        }
      });
    });
  }

  void _showNoInternetDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Network Error'),
        content: const Text('Please check your internet connection and try again.'),
        actions: [
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
              exit(0);
            },
            child: const Text('Exit'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // dismiss dialog
              _checkInternetAndStartTimer(); // try again
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _showVpnDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('VPN Detected'),
        content: const Text('VPN detected. Please close the VPN and try again.'),
        actions: [
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
              exit(0);
            },
            child: const Text('Exit'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // dismiss dialog
              _checkInternetAndStartTimer(); // try again
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: Colors.orange[100]);
            },
          ),

          // Gradient Overlay to make text readable
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.6),
                  Colors.black.withValues(alpha: 0.3),
                  Colors.black.withValues(alpha: 0.8),
                ],
              ),
            ),
          ),

          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Logo Area
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons
                      .local_shipping, // Truck icon as a placeholder for the logo
                  size: 60,
                  color: Colors.teal,
                ),
              ),

              const SizedBox(height: 20),

              // App Name
              const Text(
                'Grama Cart',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Dark teal/slate color
                ),
              ),

              const SizedBox(height: 8),

              // Hindi Tagline
              const Text(
                'गांव की हर ज़रूरत, अब घर तक',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 8),

              // English Tagline
              const Text(
                'All-in-One Village Delivery',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),

              const Spacer(flex: 3),

              // Progress Section
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Custom Progress Bar
                    Container(
                      height: 12,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: _progress,
                          backgroundColor: Colors.transparent,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
