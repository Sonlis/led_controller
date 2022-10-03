import 'package:flutter/material.dart';
import 'commonWidgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.black54),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/music': (context) => const MusicScreen(),
        '/pattern': (context) => PatternScreen(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Led controller home'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(200, 100),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/music');
                            },
                            child: const Text("Music Patterns")),
                      ])),
              Expanded(
                  flex: 1,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(200, 100),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/pattern');
                            },
                            child: const Text("Regular Patterns")),
                      ])),
            ],
          ),
        ));
  }
}

class MusicScreen extends StatelessWidget {
  const MusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Patterns'),
      ),
      body: const Center(
        child: PatternList(patterns: ["scroll", "spectrum", "energy"]),
      ),
    );
  }
}

class PatternScreen extends StatelessWidget {
  PatternScreen({super.key});
  Color currentColor = Colors.amber;
  static const patterns = [
    "color_wipe",
    "theater_chase",
    "rainbow",
    "theater_chase_rainbow",
    "rain",
    "snow",
    "ambiance",
    "fadeout"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Regular Patterns'),
        ),
        body:
          const Center(
            child: PatternList(patterns: patterns),
          ),
    );
  }
}
