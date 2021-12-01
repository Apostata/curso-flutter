Map<String, Function> validatationFunctions = {
  'required': (dynamic value, String field, dynamic ruleValue) {
    String newValue = value != null && value != '' && value != 'null'
        ? value.toString().trim()
        : '';
    final bool isValid = newValue.isNotEmpty;
    final String error = 'O campo $field Precisa ser preenchido';
    return {'isValid': isValid, 'error': error};
  },
  'email': (dynamic value, String field, dynamic ruleValue) {
    String newValue =
        value != null || value != '' ? value.toString().trim() : '';
    RegExp emailRegex = RegExp(
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?",
      caseSensitive: false,
      multiLine: false,
    );
    final isValid = emailRegex.hasMatch(newValue);
    final String error = 'O campo $field não é um email válido';
    return {'isValid': isValid, 'error': error};
  },
  'minLength': (dynamic value, String field, dynamic ruleValue) {
    String newValue =
        value != null || value != '' ? value.toString().trim() : '';
    final bool isValid = newValue.length >= ruleValue;
    final String? error =
        'O campo $field Precisa ter no mínimo $ruleValue caracteres';
    return {'isValid': isValid, 'error': error};
  },
  'maxLength': (dynamic value, String field, dynamic ruleValue) {
    String newValue =
        value != null || value != '' ? value.toString().trim() : '';
    final bool isValid = newValue.length <= ruleValue;
    final String error =
        'O campo $field Precisa ter no máximo $ruleValue caracteres';
    return {'isValid': isValid, 'error': error};
  }
};
