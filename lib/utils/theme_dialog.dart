import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch/utils/theme_provider.dart';

void showThemeOptions(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      return AlertDialog(
        title: const Text('Choose a theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: const Text('System'),
              trailing: Icon(
                themeProvider.themeMode == ThemeMode.system
                    ? Icons.circle
                    : Icons.circle_outlined,
                color: Colors.grey,
                size: 20,
              ),
              onTap: () {
                themeProvider.setThemeMode(ThemeMode.system);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Light'),
              trailing: Icon(
                themeProvider.themeMode == ThemeMode.light
                    ? Icons.circle
                    : Icons.circle_outlined,
                color: Colors.grey,
                size: 20,
              ),
              onTap: () {
                themeProvider.setThemeMode(ThemeMode.light);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Dark'),
              trailing: Icon(
                themeProvider.themeMode == ThemeMode.dark
                    ? Icons.circle
                    : Icons.circle_outlined,
                color: Colors.grey,
                size: 20,
              ),
              onTap: () {
                themeProvider.setThemeMode(ThemeMode.dark);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}