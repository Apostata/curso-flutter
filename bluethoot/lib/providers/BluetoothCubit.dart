import 'package:bluethoot/services/bluetooth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';

abstract class AppBluetoothState {
  AppBluetoothState();
}

class AppBluetoothInitialState extends AppBluetoothState {
  AppBluetoothInitialState();
}

class AppBluetoothLoadingState extends AppBluetoothState {
  AppBluetoothLoadingState();
}

class AppBluetoothScanedState extends AppBluetoothState {
  List<BluetoothDevice> devices;
  AppBluetoothScanedState({required this.devices});
}

class AppBluetoothDeviceConnectedState extends AppBluetoothState {
  BluetoothDevice device;
  AppBluetoothDeviceConnectedState({required this.device});
}

class AppBluetoothErrorState extends AppBluetoothState {
  String message;
  AppBluetoothErrorState({required this.message});
}

class AppBluetoothDisconectedState extends AppBluetoothState {
  String message;
  AppBluetoothDisconectedState({required this.message});
}

class BluetoothCubit extends Cubit<AppBluetoothState> {
  final AppBluetoothService bluetoothService = AppBluetoothService();
  BluetoothCubit(initialState) : super(initialState);
  List<BluetoothDevice> devices = [];

  void update() {
    emit(AppBluetoothLoadingState());
    bluetoothService.bluetoothState!.listen((bluetooth) {
      if (bluetooth == BluetoothState.on) {
        bluetoothService.scan();
        bluetoothService.scanResults!.listen((scanResult) {
          devices.add(scanResult.device);
          emit(
            AppBluetoothScanedState(devices: devices),
          );
        });
      }
      if (bluetooth == BluetoothState.off) {
        // bluetoothService.scanDevices!.cancel();
        bluetoothService.stopScan();
        emit(
          AppBluetoothDisconectedState(message: 'Bluetooth is off'),
        );
      }
    });
  }
}
