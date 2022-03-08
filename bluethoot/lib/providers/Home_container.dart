import 'package:bluethoot/pages/Home_page.dart';
import 'package:bluethoot/providers/BluetoothCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BluetoothCubit>(
      create: (context) {
        print('create contex Bluetooth cubit');
        final cubit = BluetoothCubit(AppBluetoothInitialState());
        cubit.update();
        return cubit;
      },
      child: const HomePage(),
    );
  }
}
