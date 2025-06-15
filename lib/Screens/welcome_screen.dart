import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch/home.dart';
import 'package:stop_watch/utils/theme_provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const Color blue = Color.fromARGB(255, 17, 29, 87);
  static const Color lightBlack = Color.fromARGB(255, 102, 102, 102);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 140,
                width: 140,
                child: Image.asset('assets/images/logo.png'),
              ),
              const SizedBox(height: 40),
              Text(
                "Ready to master your time? Let's get started.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[300] : themeProvider.accentColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement( context, MaterialPageRoute(builder: (_) => const Home() ) );
                  },
                  label: Text(
                    'Start TimeLeap >',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[300] : themeProvider.accentColor,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    iconColor: themeProvider.accentColor,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}