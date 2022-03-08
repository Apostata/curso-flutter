import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';

class AppBluetoothService {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  Stream<BluetoothState>? bluetoothState;
  Stream<ScanResult>? scanResults;
  StreamSubscription<ScanResult>? scanDevices;
  Stream<BluetoothDeviceState>? deviceState;
  AppBluetoothService() {
    checkBlutooth();
  }
  // StreamSubscription<dynamic>? deviceConnection;

  void checkBlutooth() {
    bluetoothState = flutterBlue.state;
  }

  void scan() {
    // this line will start scanning bluetooth devices
    scanResults = flutterBlue.scan();
    // scanResults?.listen((devices) {
    //   print(devices);
    // });
  }

  void stopScan() {
    flutterBlue.stopScan();
  }

  void connect(BluetoothDevice device) async {
    // need to create connection for device
    await device.connect();
    // deviceState = device.state;
    // deviceState?.listen((state) {
    //   if (state == BluetoothDeviceState.connected) {
    //     print('connectado');
    //   }
    // });
  }

  void disconnect(BluetoothDevice device) {
    device.disconnect();
  }
}
