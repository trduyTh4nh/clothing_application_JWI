import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[200],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Follow Us',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.facebook),
                onPressed: () {
                  // Add your Facebook link here
                },
              ),
              IconButton(
                icon: const Icon(Icons.tiktok),
                onPressed: () {
                  // Add your Instagram link here
                },
              ),
              IconButton(
                icon: const Icon(Icons.linked_camera),
                onPressed: () {
                  // Add your Twitter link here
                },
              ),
              IconButton(
                icon: const Icon(Icons.domain),
                onPressed: () {
                  // Add your YouTube link here
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '© 2024 JWT Store',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
