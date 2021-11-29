import 'package:chat/helpers/FieldValidation.dart';

class FormValidation {
  bool valid;
  Map<String, FieldValidation> fields;

  FormValidation({this.valid = true, required this.fields});

  FormValidation checkFieldValidity(
      {required String fieldName, required dynamic value}) {
    final field = fields[fieldName]!.checkFieldValidity(value, fieldName);
    Map<String, FieldValidation> newFields = {...fields};
    valid = field.valid;
    newFields.remove(fieldName);
    newFields.forEach((key, fieldsvalue) {
      valid = newFields[key]!.valid && valid;
       print('$key: $value,(${newFields[key]!.valid}) / currentField/ $fieldName: ${field.valid}');
    });

    return this;
  }

  FormValidation checkFormValidity(
      FormValidation formValidation, Map<String, dynamic> formData) {
    valid = true;
    Map<String, FieldValidation> fieldsForm = formValidation.fields;
    fieldsForm.forEach((fieldName, value) {
      final String newValue = formData[fieldName].toString();
      final field = fields[fieldName]!.checkFieldValidity(newValue, fieldName);
      valid = field.valid && valid;
    });
    return this;
  }
}
