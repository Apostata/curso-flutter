import 'package:chat/helpers/validationFunctions.dart';

class FieldValidation {
  bool valid;
  bool touched;
  String? error;
  Map<String, dynamic> rules;
  FieldValidation(
      {required this.rules, this.valid = false, this.touched = false});

  FieldValidation checkFieldValidity(value, field) {
    _checkRules(value, field);
    return this;
  }

  void changeRuleValidation(String rule, dynamic value) {
    rules[rule] = value;
  }

  void clearFieldValidation({bool valid = true}) {
    valid = valid;
    touched = false;
    error = null;
    rules.forEach((key, value) {
      rules[key] = rules[key] is bool ? true : rules[key];
    });
  }

  void _checkRules(dynamic value, String field) {
    touched = true;
    valid = true;
    rules.forEach((key, ruleValue) {
      if (validatationFunctions[key] != null || ruleValue != false) {
        final res = validatationFunctions[key]!(value, field, ruleValue)
            as Map<String, dynamic>;
        valid = res['isValid'] && valid;
        error = res['error'];
      }
    });
  }
}
