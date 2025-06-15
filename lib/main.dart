import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch/screens/splash_screen.dart';
import 'package:stop_watch/utils/theme.dart';
import 'package:stop_watch/utils/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const StopWatch(),
    ),
  );
}

class StopWatch extends StatelessWidget {
  const StopWatch({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TimeLeap',
          theme: lightTheme(themeProvider.accentColor),
          darkTheme: darkTheme(themeProvider.accentColor),
          themeMode: themeProvider.themeMode,
          home: const SplashScreen(),
        );
      },
    );
  }
}