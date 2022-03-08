// import 'package:bluethoot/services/bluetooth_service.dart';
import 'package:bluethoot/components/Device_item.dart';
import 'package:bluethoot/providers/BluetoothCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final AppBluetoothService bluetoothService = AppBluetoothService();
    return Scaffold(
      appBar: AppBar(
        title: const Text('POC Bluetooth'),
      ),
      body: BlocBuilder<BluetoothCubit, AppBluetoothState>(
          builder: (context, state) {
        if (state is AppBluetoothInitialState ||
            state is AppBluetoothLoadingState) {
          return const Center(
            child: Text('Loading...'),
          );
        }
        if (state is AppBluetoothDisconectedState) {
          return const Center(
            child: Text(
                'Device Bluetooth deactivated! please activate to continue!'),
          );
        }
        if (state is AppBluetoothScanedState) {
          final devices = state.devices;
          return ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, index) {
                return DeviceItem(
                  device: devices[index],
                );
              });
        } else {
          return const Center(
            child: Text('Deu Ruim!'),
          );
        }
      }),
    );
  }
}
