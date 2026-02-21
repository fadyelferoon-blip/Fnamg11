import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants.dart';
import '../core/animation.dart';
import '../widgets/animated_background.dart';
import 'uid_input_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  Future<void> _launchRegistration() async {
    final Uri url = Uri.parse(AppConstants.registrationUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  void _navigateToUIDInput(BuildContext context) {
    Navigator.of(context).push(
      AppAnimations.createRoute(const UidInputScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    // Logo
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(AppConstants.gold),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(AppConstants.gold).withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'F',
                          style: TextStyle(
                            fontSize: 50,
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
                    
                    const SizedBox(height: 10),
                    
                    Text(
                      'Professional Trading Platform',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: const Color(AppConstants.gold).withOpacity(0.7),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 60),
                    
                    // Register Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _launchRegistration,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                        ),
                        child: const Text('REGISTER'),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Already Have Account Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => _navigateToUIDInput(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                        ),
                        child: const Text('I ALREADY HAVE ACCOUNT'),
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    Text(
                      'Get started with premium trading signals',
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
