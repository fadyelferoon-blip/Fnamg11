import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants.dart';

class SupportButton extends StatelessWidget {
  const SupportButton({Key? key}) : super(key: key);

  Future<void> _launchSupport() async {
    final Uri url = Uri.parse(AppConstants.supportUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton.icon(
        onPressed: _launchSupport,
        icon: const Icon(Icons.support_agent, size: 20),
        label: const Text(
          'SUPPORT',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(AppConstants.gold),
          side: const BorderSide(
            color: Color(AppConstants.gold),
            width: 2,
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
