import 'package:flutter/material.dart';

import 'finger_painter/presentation/finger_painter_screen.dart';
import 'info/info_screen_io.dart' if (dart.library.js_interop) 'info/info_screen_web.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: FractionallySizedBox(
        widthFactor: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const InfoScreen()));
              },
              child: const Text('Go to Platform Info or Web Info'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FingerPainterScreen()));
              },
              child: const Text('Go to Finger Painter'),
            ),
          ],
        ),
      ),
    );
  }
}
