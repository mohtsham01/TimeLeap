import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch/utils/theme_provider.dart';

class StopWatchPage extends StatefulWidget {
  const StopWatchPage({super.key});

  @override
  State<StopWatchPage> createState() => _StopWatchPageState();
}

class _StopWatchPageState extends State<StopWatchPage> {
  static const Color red600 = Color(0xFFDC2626);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray800 = Color(0xFF1F2937);

  late Stopwatch _stopwatch;
  Duration _lastElapsed = Duration.zero;
  bool _isRunning = false;
  final List<Duration> _laps = [];

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  @override
  void dispose() {
    _stopwatch.stop();
    super.dispose();
  }

  void _startStopwatch() {
    setState(() {
      _isRunning = true;
      _stopwatch.start();
    });
  }

  void _stopStopwatch() {
    setState(() {
      _isRunning = false;
      _stopwatch.stop();
      _lastElapsed = _stopwatch.elapsed;
    });
  }

  void _resetStopwatch() {
    setState(() {
      _isRunning = false;
      _stopwatch.reset();
      _lastElapsed = Duration.zero;
      _laps.clear();
    });
  }

  void _recordLap() {
    setState(() {
      _laps.insert(0, _stopwatch.elapsed); // Insert at beginning instead of adding to end
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : const Color(0xFFf2f2f2),
      extendBodyBehindAppBar: true,
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
              Image.asset('assets/images/logo-icon.png', width: 40, height: 40),
              const SizedBox(width: 8),
              Text(
                'TimeLeap',
                style: TextStyle( color: themeProvider.accentColor, fontSize: 20, fontWeight: FontWeight.w600 ),
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
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TimeDisplay(
                      isRunning: _isRunning,
                      stopwatch: _stopwatch,
                      lastElapsed: _lastElapsed,
                    ),
                    const SizedBox(height: 16),
                    if (_isRunning)
                      ElevatedButton(
                        onPressed: _recordLap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeProvider.accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Inter',
                            fontSize: 16,
                          ),
                        ),
                        child: const Text(
                          'Lap',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 140),
                            child: ElevatedButton(
                              onPressed: _isRunning ? _stopStopwatch : _startStopwatch,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isRunning ? red600 : themeProvider.accentColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                ),
                              ),
                              child: Text(
                                _isRunning ? 'Stop' : 'Start',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 140),
                            child: ElevatedButton(
                              onPressed: _resetStopwatch,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isDark ? Colors.grey[700] : gray200,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                ),
                                foregroundColor: isDark ? Colors.white : gray800,
                              ),
                              child: const Text('Reset'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (_laps.isNotEmpty)
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 24, bottom: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Text(
                        'Laps Record',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : gray800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _laps.length,
                          itemBuilder: (context, index) {
                            final num = _laps.length - index;
                            final lapTime = _formatDuration(_laps[index]);
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: isDark ? Colors.grey[800] : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: isDark ? Colors.grey[700]! : gray200),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Lap $num',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: isDark ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    themeProvider.showMilliseconds
                                        ? '${lapTime['main']!}${lapTime['fraction']!}'
                                        : lapTime['main']!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'monospace',
                                      color: isDark ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Map<String, String> _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(duration.inHours.remainder(60));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final centiseconds = twoDigits(duration.inMilliseconds.remainder(1000) ~/ 10);

    return {
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds,
      'centiseconds': centiseconds,
      'main': '$hours:$minutes:$seconds',
      'fraction': '.${centiseconds.substring(0, 2)}',
    };
  }
}

class TimeDisplay extends StatelessWidget {
  final bool isRunning;
  final Stopwatch stopwatch;
  final Duration lastElapsed;

  const TimeDisplay({
    super.key,
    required this.isRunning,
    required this.stopwatch,
    required this.lastElapsed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey[700]! : const Color(0xFFE5E7EB),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 24),
      width: double.infinity,
      child: StreamBuilder(
        stream: Stream.periodic(const Duration(milliseconds: 100)),
        builder: (context, snapshot) {
          final elapsed = isRunning ? stopwatch.elapsed : lastElapsed;
          final formattedTime = _formatDuration(elapsed);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                formattedTime['main']!,
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : themeProvider.accentColor,
                  fontFamily: 'Inter',
                  height: 1,
                ),
              ),
              if (themeProvider.showMilliseconds)
                Column(
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      formattedTime['fraction']!,
                      style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : themeProvider.accentColor,
                        fontFamily: 'Inter',
                        height: 1,
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }

  Map<String, String> _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(duration.inHours.remainder(60));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final centiseconds = twoDigits(duration.inMilliseconds.remainder(1000) ~/ 10);

    return {
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds,
      'centiseconds': centiseconds,
      'main': '$hours:$minutes:$seconds',
      'fraction': '.${centiseconds.substring(0, 2)}',
    };
  }
}