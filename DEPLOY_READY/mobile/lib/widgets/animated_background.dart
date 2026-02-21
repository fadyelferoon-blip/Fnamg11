import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/constants.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({Key? key}) : super(key: key);

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: BackgroundPainter(_controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final double animationValue;

  BackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    
    // Gradient background
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(AppConstants.primaryBlack),
        const Color(AppConstants.darkGray),
      ],
    );
    
    canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
    
    // Animated circles
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(AppConstants.gold).withOpacity(0.03);
    
    for (int i = 0; i < 5; i++) {
      final offset = Offset(
        size.width * (0.2 + i * 0.15),
        size.height * (0.3 + math.sin(animationValue * 2 * math.pi + i) * 0.2),
      );
      
      final radius = 50.0 + math.cos(animationValue * 2 * math.pi + i) * 20;
      
      canvas.drawCircle(offset, radius, paint);
    }
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
