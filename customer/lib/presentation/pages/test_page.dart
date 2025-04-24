import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Test Page Loaded Successfully',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Print some debug info
                debugPrint(
                    'Firebase configuration: ${const bool.hasEnvironment('FIREBASE_API_KEY') ? 'Available' : 'Not available'}');
                debugPrint('Network configuration: Base URL is set');
              },
              child: const Text('Test Firebase Config'),
            ),
          ],
        ),
      ),
    );
  }
}
