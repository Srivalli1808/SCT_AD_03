import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StopwatchHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StopwatchHomePage extends StatefulWidget {
  @override
  _StopwatchHomePageState createState() => _StopwatchHomePageState();
}

class _StopwatchHomePageState extends State<StopwatchHomePage> {
  // Variables to handle the stopwatch logic
  late Stopwatch _stopwatch;
  Timer? _timer; // Timer can be nullable to check if it's running

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  // Start the timer that updates the UI
  void _startTimer() {
    if (_timer != null && _timer!.isActive) {
      return; // Don't start another timer if it's already running
    }
    _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {}); // Updates the UI every 30 milliseconds
    });
  }

  // Format the stopwatch time
  String _formatTime(int milliseconds) {
    int minutes = (milliseconds / 60000).floor();
    int seconds = ((milliseconds % 60000) / 1000).floor();
    int milliSeconds = (milliseconds % 1000).floor();
    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}:'
        '${milliSeconds.toString().padLeft(3, '0')}';
  }

  // Start the stopwatch
  void _startStopwatch() {
    _stopwatch.start();
    _startTimer();
  }

  // Pause the stopwatch
  void _pauseStopwatch() {
    _stopwatch.stop();
    _timer?.cancel(); // Cancel the timer when paused
  }

  // Reset the stopwatch
  void _resetStopwatch() {
    _stopwatch.reset();
    setState(() {}); // Reset the UI immediately
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _formatTime(_stopwatch.elapsedMilliseconds),
              style: TextStyle(fontSize: 48.0),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _stopwatch.isRunning ? null : _startStopwatch,
                  child: Text('Start'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _stopwatch.isRunning ? _pauseStopwatch : null,
                  child: Text('Pause'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: !_stopwatch.isRunning && _stopwatch.elapsedMilliseconds > 0
                      ? _resetStopwatch
                      : null,
                  child: Text('Reset'),
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
