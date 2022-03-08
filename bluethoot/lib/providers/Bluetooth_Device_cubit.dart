import 'package:bluethoot/services/bluetooth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';

abstract class AppBluetoothDeviceState {
  AppBluetoothDeviceState();
}

class AppBluetoothDeviceInitialState extends AppBluetoothDeviceState {
  AppBluetoothDeviceInitialState();
}

class AppBluetoothDeviceLoadingState extends AppBluetoothDeviceState {
  AppBluetoothDeviceLoadingState();
}

class AppBluetoothDeviceConnectedState extends AppBluetoothDeviceState {
  BluetoothDevice device;
  AppBluetoothDeviceConnectedState({required this.device});
}

class AppBluetoothDeviceErrorState extends AppBluetoothDeviceState {
  String message;
  AppBluetoothDeviceErrorState({required this.message});
}

class AppBluetoothDeviceDisconectedState extends AppBluetoothDeviceState {
  String message;
  AppBluetoothDeviceDisconectedState({required this.message});
}

class BluetoothDeviceCubit extends Cubit<AppBluetoothDeviceState> {
  final AppBluetoothService bluetoothService = AppBluetoothService();
  BluetoothDeviceCubit(initialState) : super(initialState);
  BluetoothDevice? device;

  void connectDevice(BluetoothDevice device) {
    emit(AppBluetoothDeviceLoadingState());
    bluetoothService.connect(device);
    device.state.listen((state) {
      if (state == BluetoothDeviceState.connected) {
        emit(
          AppBluetoothDeviceConnectedState(device: device),
        );
      }
      if (state == BluetoothDeviceState.disconnected) {
        emit(
          AppBluetoothDeviceDisconectedState(
              message:
                  'Device id:${device.id.toString()} ${device.name != '' ? 'name:${device.name}' : ''} is Disconnected!'),
        );
      }
    });
  }
}
