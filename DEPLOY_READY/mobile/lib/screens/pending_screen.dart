import 'package:flutter/material.dart';
import 'dart:async';
import '../core/constants.dart';
import '../core/animation.dart';
import '../services/auth_server.dart';
import '../widgets/animated_background.dart';
import 'trading_screen.dart';
import 'welcome_screen.dart';

class PendingScreen extends StatefulWidget {
  const PendingScreen({Key? key}) : super(key: key);

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen>
    with SingleTickerProviderStateMixin {
  final AuthService _authService = AuthService();
  Timer? _checkTimer;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
    _startStatusCheck();
  }

  void _setupAnimation() {
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  void _startStatusCheck() {
    _checkTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _checkStatus();
    });
  }

  Future<void> _checkStatus() async {
    final result = await _authService.checkUserStatus();

    if (!mounted) return;

    if (result['success']) {
      String status = result['data']['status'];

      if (status == 'APPROVED') {
        _checkTimer?.cancel();
        _navigateToTrading();
      } else if (status == 'BLOCKED') {
        _checkTimer?.cancel();
        _showBlockedDialog();
      }
    }
  }

  void _showBlockedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(AppConstants.mediumGray),
        title: const Text(
          'Account Blocked',
          style: TextStyle(color: Colors.red),
        ),
        content: const Text(
          'Your account has been blocked. Please contact support.',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _authService.logout();
              Navigator.of(context).pushAndRemoveUntil(
                AppAnimations.fadeRoute(const WelcomeScreen()),
                (route) => false,
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _navigateToTrading() {
    Navigator.of(context).pushReplacement(
      AppAnimations.fadeRoute(const TradingScreen()),
    );
  }

  @override
  void dispose() {
    _checkTimer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedBackground(),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated Icon
                    AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _pulseAnimation.value,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: const Color(AppConstants.goldAccent)
                                  .withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(AppConstants.gold),
                                width: 3,
                              ),
                            ),
                            child: const Icon(
                              Icons.access_time,
                              size: 60,
                              color: Color(AppConstants.gold),
                            ),
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 40),
                    
                    Text(
                      'Pending Approval',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 28,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    Text(
                      'Your account is awaiting admin approval',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 40),
                    
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(AppConstants.mediumGray)
                            .withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(AppConstants.gold).withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: Color(AppConstants.gold),
                            size: 30,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            'What happens next?',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 16,
                              color: const Color(AppConstants.gold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '• Admin will review your account\n'
                            '• You will be notified when approved\n'
                            '• This usually takes a few minutes',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 14,
                              color: Colors.white60,
                              height: 1.8,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Refresh Button
                    OutlinedButton.icon(
                      onPressed: _checkStatus,
                      icon: const Icon(Icons.refresh),
                      label: const Text('CHECK STATUS'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    Text(
                      'Checking status automatically...',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 12,
                        color: Colors.white38,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
