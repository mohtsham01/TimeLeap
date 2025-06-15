import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch/utils/theme_dialog.dart';
import 'package:stop_watch/utils/theme_provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  void _showColorOptions(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose a Colour'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ThemeProvider.availableColors.entries.map((entry) {
              return ListTile(
                title: Text(entry.key),
                trailing: Icon(
                  themeProvider.accentColor == entry.value
                      ? Icons.circle
                      : Icons.circle_outlined,
                  color: entry.value,
                ),
                onTap: () {
                  themeProvider.setAccentColor(entry.value, entry.key);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          toolbarHeight: 60,
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.settings_outlined,
                size: 28,
                color: themeProvider.accentColor,
              ),
              const SizedBox(width: 8),
              Text(
                'Settings',
                style: TextStyle(
                  color: themeProvider.accentColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isDark ? Colors.grey[800]! : Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: [
          Text(
            "Appearance",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.grey[400] : Colors.grey,
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            leading: Icon(
              Icons.light_mode_rounded,
              size: 20,
              color: isDark ? Colors.grey[500] : Colors.grey[400],
            ),
            title: Text(
              'Theme',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            subtitle: Text(
              themeProvider.themeMode == ThemeMode.system
                  ? 'System'
                  : themeProvider.themeMode == ThemeMode.light
                      ? 'Light'
                      : 'Dark',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.grey[400] : Colors.grey,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              size: 20,
              color: isDark ? Colors.grey[400] : Colors.grey,
            ),
            onTap: () => showThemeOptions(context),
          ),
          Opacity(
            opacity: 0.2,
            child: Divider(height: 1, color: isDark ? Colors.grey[700] : null),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            leading: Icon(
              Icons.format_paint_outlined,
              color: isDark ? Colors.grey[500] : Colors.grey[400],
              size: 20,
            ),
            title: Text(
              'Accent Color',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: isDark ? Colors.white : Colors.black87,
                fontFamily: 'Inter',
              ),
            ),
            subtitle: Text(
              themeProvider.accentColorName,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.grey[400] : Colors.grey,
                fontFamily: 'Inter',
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: isDark ? Colors.grey[400] : Colors.grey,
              size: 20,
            ),
            onTap: () => _showColorOptions(context),
          ),
          Opacity(
            opacity: 0.2,
            child: Divider(height: 0.5, color: isDark ? Colors.grey[700] : null),
          ),
          const SizedBox(height: 20),
          Text(
            "Display",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.grey[400] : Colors.grey,
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            title: Text(
              'Show Milliseconds',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: isDark ? Colors.white : Colors.black87,
                fontFamily: 'Inter',
              ),
            ),
            trailing: Transform.scale(
              scale: 0.7,
              child: Switch(
                value: themeProvider.showMilliseconds,
                activeColor: themeProvider.accentColor,
                onChanged: (val) {
                  setState(() {
                    themeProvider.setShowMilliseconds(val);
                  });
                },
              ),
            ),
          ),
          Opacity(
            opacity: 0.2,
            child: Divider(height: 1, color: isDark ? Colors.grey[700] : null),
          ),
        ],
      ),
    );
  }
}