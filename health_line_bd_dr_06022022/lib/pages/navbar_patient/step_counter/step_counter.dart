import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';

// String formatDate(DateTime d) {
//   return d.toString().substring(0, 19);
// }

class StepCounterPage extends StatefulWidget {
  @override
  _StepCounterPageState createState() => _StepCounterPageState();
}

class _StepCounterPageState extends State<StepCounterPage> {
  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    if (this.mounted) {
      setState(() {
        _status = event.status;
      });
    }
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountErPageror(error) {
    print('onStepCountErPageror: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountErPageror);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: const Text('Step Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Steps taken:',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              _steps,
              style: TextStyle(fontSize: 60),
            ),
            Divider(
              height: 100,
              thickness: 0,
              color: Colors.white,
            ),
            Text(
              'Pedestrian status:',
              style: TextStyle(fontSize: 30),
            ),
            Icon(
              _status == 'walking'
                  ? Icons.directions_walk
                  : _status == 'stopped'
                      ? Icons.accessibility_new
                      : Icons.error,
              size: 100,
            ),
            Center(
              child: Text(
                _status,
                style: _status == 'walking' || _status == 'stopped'
                    ? TextStyle(fontSize: 30)
                    : TextStyle(fontSize: 20, color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}
