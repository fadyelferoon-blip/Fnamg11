import 'package:flutter/material.dart';
import 'dart:async';
import '../core/constants.dart';
import '../services/api_service.dart';
import '../services/storage_server.dart';

class SignalButton extends StatefulWidget {
  const SignalButton({Key? key}) : super(key: key);

  @override
  State<SignalButton> createState() => _SignalButtonState();
}

class _SignalButtonState extends State<SignalButton> {
  final ApiService _api = ApiService();
  final StorageService _storage = StorageService();
  
  bool _isGenerating = false;
  String? _currentSignal;
  int _countdown = 0;
  Timer? _countdownTimer;

  void _generateSignal() async {
    if (_isGenerating || _countdown > 0) return;

    setState(() {
      _isGenerating = true;
    });

    try {
      final uid = _storage.getUID();
      final deviceId = _storage.getDeviceId();

      if (uid == null || deviceId == null) {
        _showError('User data not found');
        return;
      }

      final result = await _api.generateSignal(uid, deviceId);

      if (!mounted) return;

      if (result['success']) {
        final signalData = result['data']['signal'];
        final signalType = signalData['type'] as String;

        setState(() {
          _currentSignal = signalType;
          _countdown = AppConstants.signalDuration;
        });

        _startCountdown();
      } else {
        if (result['waitSeconds'] != null) {
          _showError(
            'Signal can only be generated at the start of a new minute. '
            'Wait ${result['waitSeconds']} seconds.',
          );
        } else {
          _showError(result['error'] ?? 'Failed to generate signal');
        }
      }
    } catch (e) {
      _showError('Error: $e');
    } finally {
      setState(() {
        _isGenerating = false;
      });
    }
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _countdown--;
        if (_countdown <= 0) {
          _currentSignal = null;
          timer.cancel();
        }
      });
    });
  }

  void _showError(String message) {
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Color _getSignalColor() {
    if (_currentSignal == 'CALL') {
      return Colors.green;
    } else if (_currentSignal == 'PUT') {
      return Colors.red;
    }
    return const Color(AppConstants.gold);
  }

  String _getButtonText() {
    if (_countdown > 0 && _currentSignal != null) {
      return '$_currentSignal ($_countdown s)';
    } else if (_isGenerating) {
      return 'GENERATING...';
    } else {
      return 'GET SIGNAL';
    }
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: (_isGenerating || _countdown > 0) ? null : _generateSignal,
        style: ElevatedButton.styleFrom(
          backgroundColor: _getSignalColor(),
          foregroundColor: Colors.white,
          disabledBackgroundColor: _getSignalColor().withOpacity(0.6),
          disabledForegroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isGenerating)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            if (_isGenerating) const SizedBox(width: 10),
            Text(
              _getButtonText(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            if (_currentSignal != null) ...[
              const SizedBox(width: 10),
              Icon(
                _currentSignal == 'CALL'
                    ? Icons.arrow_upward
                    : Icons.arrow_downward,
                size: 24,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
