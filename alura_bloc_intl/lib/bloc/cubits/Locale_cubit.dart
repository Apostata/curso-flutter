import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<String> {
  final String language;
  LocaleCubit(this.language) : super(language);
}
