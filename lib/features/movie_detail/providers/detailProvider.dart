import 'package:flutter/foundation.dart';
// import 'package:sensors_plus/sensors_plus.dart';

class SensorProvider with ChangeNotifier {
  double _x = 0.0;
  double _y = 0.0;
  // StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;

  double get x => _x;
  double get y => _y;

  // void startListening() {
  //   _accelerometerSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
  //     _x = event.x.clamp(-5, 5) / 50;
  //     _y = event.y.clamp(-5, 5) / 50;
  //     notifyListeners();
  //   });
  // }

  // void stopListening() {
  //   _accelerometerSubscription?.cancel();
  //   _accelerometerSubscription = null;
  // }

  @override
  void dispose() {
    // stopListening();
    super.dispose();
  }
}
