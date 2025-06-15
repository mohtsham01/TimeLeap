import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch/pages/setting.dart';
import 'package:stop_watch/pages/stop_watch.dart';
import 'package:stop_watch/utils/theme_provider.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  List<PersistentTabConfig> _tabs(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return [
      PersistentTabConfig(
        screen: const StopWatchPage(),
        item: ItemConfig(
          icon: const Icon(Icons.timer_outlined),
          title: "Stopwatch",
          textStyle: const TextStyle(fontSize: 15),
          iconSize: 23.0,
          activeForegroundColor: themeProvider.accentColor,
          inactiveForegroundColor: Colors.grey,
        ),
      ),
      PersistentTabConfig(
        screen: const SettingPage(),
        item: ItemConfig(
          icon: const Icon(Icons.settings_outlined),
          title: "Settings",
          textStyle: const TextStyle(fontSize: 15),
          iconSize: 23.0,
          activeForegroundColor: themeProvider.accentColor,
          inactiveForegroundColor: Colors.grey,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return PersistentTabView(
      tabs: _tabs(context),
      navBarBuilder: (navBarConfig) => Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isDarkMode ? Colors.grey[800]! : Colors.grey,
              width: 0.5,
            ),
          ),
          color: isDarkMode ? Colors.grey[900] : Colors.white,
        ),
        child: Style1BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: NavBarDecoration(
            color: isDarkMode ? Colors.grey[900]! : Colors.white,
          ),
        ),
      ),
    );
  }
}