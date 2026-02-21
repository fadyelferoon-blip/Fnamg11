import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/animation.dart';
import '../services/auth_server.dart';
import '../widgets/animated_background.dart';
import 'pending_screen.dart';
import 'trading_screen.dart';

class UidInputScreen extends StatefulWidget {
  const UidInputScreen({Key? key}) : super(key: key);

  @override
  State<UidInputScreen> createState() => _UidInputScreenState();
}

class _UidInputScreenState extends State<UidInputScreen> {
  final TextEditingController _uidController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _submitUID() async {
    final uid = _uidController.text.trim();

    if (uid.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter your Quotex Account ID';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await _authService.register(uid);

      if (!mounted) return;

      if (result['success']) {
        final userData = result['data']['user'];
        String status = userData['status'];

        if (status == 'APPROVED') {
          _navigateToTrading();
        } else if (status == 'PENDING') {
          _navigateToPending();
        } else if (status == 'BLOCKED') {
          setState(() {
            _errorMessage = 'This account has been blocked';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage = result['error'] ?? 'Registration failed';
          _isLoading = false;
        });

        if (result['error'] == 'BLOCKED') {
          _showBlockedDialog(result['message']);
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again.';
        _isLoading = false;
      });
    }
  }

  void _showBlockedDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(AppConstants.mediumGray),
        title: const Text(
          'Account Blocked',
          style: TextStyle(color: Colors.red),
        ),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
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
    _uidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          const AnimatedBackground(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Enter Your Account ID',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 10),
                    
                    Text(
                      'Your Quotex Account ID (UID)',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white60,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 50),
                    
                    // UID Input Field
                    TextField(
                      controller: _uidController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Enter UID',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.3),
                        ),
                        prefixIcon: const Icon(
                          Icons.account_circle,
                          color: Color(AppConstants.gold),
                        ),
                      ),
                      enabled: !_isLoading,
                    ),
                    
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.red.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error, color: Colors.red, size: 20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    
                    const SizedBox(height: 40),
                    
                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submitUID,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.black,
                                  ),
                                ),
                              )
                            : const Text('CONTINUE'),
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    Text(
                      'Your device will be registered automatically',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 12,
                        color: Colors.white38,
                      ),
                      textAlign: TextAlign.center,
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
