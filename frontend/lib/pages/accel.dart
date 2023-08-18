import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';

class AccelerometerScreen extends StatefulWidget {
  const AccelerometerScreen({super.key});

  @override
  State<AccelerometerScreen> createState() => _AccelerometerScreenState();
}

class _AccelerometerScreenState extends State<AccelerometerScreen> {
  List<double> _accelerometerValue = [];
  final List<StreamSubscription<dynamic>> _streamSubscription = [];

  @override
  void initState() {
    _streamSubscription.add(accelerometerEvents!.listen((event) {
      setState(() {
        _accelerometerValue = [event.x, event.y, event.z];
      });
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> accelerometer =
        _accelerometerValue.map((double v) => v.toStringAsFixed(1)).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accelerometer'),
      ),
      body: Center(
        child: Text(
          'Accelerometer values:\n \n X: ${accelerometer[0]} , Y : ${accelerometer[0]} , Z : ${accelerometer[0]}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}