import 'package:flutter/material.dart';
import 'dart:async';

class StopwatchWidget extends StatefulWidget {
  @override
  _StopwatchWidgetState createState() => _StopwatchWidgetState();
}

class _StopwatchWidgetState extends State<StopwatchWidget> {
  Timer? _timer;
  int _elapsedTime = 0;

  void _startTimer() {
    if (_timer != null && _timer!.isActive) return;
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _elapsedTime++;
      });
    });
  }

  void _pauseTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void _resetTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _elapsedTime = 0;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 258,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Elapsed Time: ${_elapsedTime ~/ 100}:${_elapsedTime % 100} ',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _startTimer,
                child: Text('Start'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _pauseTimer,
                child: Text('Pause'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _resetTimer,
                child: Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
