import 'package:chat/helpers/FieldValidation.dart';

Map<String, Map<String, FieldValidation>> auth_form_validation = {
  'signup': {
    'name': FieldValidation(
      rules: {'minLength': 3},
      valid: false,
      touched: false,
    ),
    'email': FieldValidation(
      rules: {'email': true},
      valid: false,
      touched: false,
    ),
    'password': FieldValidation(
      rules: {'minLength': 6},
      valid: false,
      touched: false,
    ),
    // 'image': FieldValidation(
    //   rules: {'required': true},
    //   valid: false,
    //   touched: false,
    // )
  },
  'login': {
    'email': FieldValidation(
      rules: {'email': true},
      valid: false,
      touched: false,
    ),
    'password': FieldValidation(
      rules: {'minLength': 6},
      valid: false,
      touched: false,
    ),
  }
};
