import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/animation.dart';
import '../services/auth_server.dart';
import '../services/storage_server.dart';
import 'welcome_screen.dart';
import 'pending_screen.dart';
import 'trading_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  final AuthService _authService = AuthService();
  final StorageService _storage = StorageService();

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeApp();
  }

  void _setupAnimations() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  Future<void> _initializeApp() async {
    // Initialize storage
    await _storage.init();

    // Wait for animation
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Check if user has data
    if (_authService.hasUserData()) {
      // Check status
      final result = await _authService.checkUserStatus();
      
      if (result['success']) {
        String status = result['data']['status'];
        
        if (status == 'APPROVED') {
          _navigateToTrading();
        } else if (status == 'BLOCKED') {
          _navigateToWelcome();
        } else {
          _navigateToPending();
        }
      } else {
        _navigateToWelcome();
      }
    } else {
      _navigateToWelcome();
    }
  }

  void _navigateToWelcome() {
    Navigator.of(context).pushReplacement(
      AppAnimations.fadeRoute(const WelcomeScreen()),
    );
  }

  void _navigateToPending() {
    Navigator.of(context).pushReplacement(
      AppAnimations.fadeRoute(const PendingScreen()),
    );
  }

  void _navigateToTrading() {
    Navigator.of(context).pushReplacement(
      AppAnimations.fadeRoute(const TradingScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(AppConstants.primaryBlack),
              const Color(AppConstants.darkGray),
            ],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _opacityAnimation.value,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo placeholder
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: const Color(AppConstants.gold),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(AppConstants.gold).withOpacity(0.5),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'F',
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        AppConstants.appName,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
