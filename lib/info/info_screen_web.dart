import 'dart:js_interop';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

@JS()
external Window get window;

@JS()
@staticInterop
class Window {}

extension WindowExtension on Window {
  @JS('navigator')
  external WebNavigator get navigator;
  @JS('screen')
  external Screen get screen;
  @JS('alert')
  external void alert(String message);
  @JS('open')
  external void open(String url, String target);
}

@JS()
@staticInterop
class WebNavigator {}

extension WebNavigatorExtension on WebNavigator {
  @JS('userAgent')
  external String get userAgent;
  @JS('language')
  external String get language;
}

@JS()
@staticInterop
class Screen {}

extension ScreenExtension on Screen {
  @JS('width')
  external int get width;
  @JS('height')
  external int get height;
}

extension type JSPerson._(JSObject _) implements JSObject {
  external JSPerson({
    JSString? name,
    JSNumber? age,
  });

  external JSString? get name;
  external JSNumber? get age;
}

@JS()
external JSPerson getPerson();

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return Scaffold(
        appBar: AppBar(title: const Text('Web Platform Info')),
        body: const Center(
          child: Text('This screen is only available in web browser'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Web Platform Info')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Web Browser Information:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Text('User Agent: ${window.navigator.userAgent}',
                  style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text('Browser Language: ${window.navigator.language}',
                  style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text(
                'Screen Size: ${window.screen.width}x${window.screen.height}',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  window.alert('Hello from Web!');
                },
                child: const Text('Show Alert'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  window.open('https://flutter.dev', 'Flutter');
                },
                child: const Text('Open Flutter Website'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  final person = getPerson();
                  window.alert('Name: ${person.name}, Age: ${person.age}');
                },
                child: const Text('Get person'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
