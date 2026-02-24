import 'package:expenses_app/widgets/expanses.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 7, 193, 244),
);
var darkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 3, 25, 60),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB), // Blue modern
          brightness: Brightness.light,
        ),

        scaffoldBackgroundColor: const Color.fromARGB(255, 249, 250, 250),

        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
        ),

        cardTheme: CardThemeData(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      home: Expanses(),
    );
  }
}
