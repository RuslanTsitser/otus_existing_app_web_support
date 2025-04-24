import 'dart:io';

import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Native Platform Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Platform Information:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text('Operating System: ${Platform.operatingSystem}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('OS Version: ${Platform.operatingSystemVersion}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Number of Processors: ${Platform.numberOfProcessors}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // This will only work on native platforms
                final tempDir = Directory.systemTemp;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Temp directory: ${tempDir.path}')));
              },
              child: const Text('Show Temp Directory'),
            ),
          ],
        ),
      ),
    );
  }
}
