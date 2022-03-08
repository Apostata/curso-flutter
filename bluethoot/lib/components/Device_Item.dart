import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceItem extends StatelessWidget {
  final BluetoothDevice device;
  const DeviceItem({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(device.id.toString()),
            Text(device.name != '' ? device.name : 'Unknow device')
          ],
        ),
        ElevatedButton(
          onPressed: () => {},
          child: const Text('Conectar'),
        ),
      ],
    );
  }
}
