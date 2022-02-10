import 'package:flutter_bloc/flutter_bloc.dart';

class NameCubit extends Cubit<String> {
  NameCubit(String initialName) : super(initialName);
  void change(String name) => emit(name);
}
