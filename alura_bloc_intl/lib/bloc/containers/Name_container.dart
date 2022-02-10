import 'package:alura_bloc_intl/bloc/cubits/Name_cubit.dart';
import 'package:alura_bloc_intl/pages/name_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameContainer extends StatelessWidget {
  const NameContainer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (blocContext) => NameCubit('Rene'),
      child: NamePage(),
    );
  }
}
