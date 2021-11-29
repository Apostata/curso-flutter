import 'dart:io';

import 'package:chat/components/user_image_picker.dart';
import 'package:chat/helpers/FormValidation.dart';
import 'package:chat/models/auth_form_data.dart';
import 'package:flutter/material.dart';
import 'package:chat/validations/auth_form.validation.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key, required this.onSubmit}) : super(key: key);
  final Function(AuthFormData) onSubmit;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _authData = AuthFormData();
  final _formKey = GlobalKey<FormState>();

  late FormValidation authDataValidation;

  void _imagePick(File image) {
    _authData.image = image;
  }

  Map<String, dynamic> _mountValidationFields() {
    Map<String, dynamic> validationFields = _authData.isSignup
        ? {
            'name': _authData.name,
            'email': _authData.email,
            'password': _authData.password,
            'image': _authData.image,
          }
        : {'email': _authData.email, 'password': _authData.password};
    return validationFields;
  }

  void _submit() {
    setState(() => {
          authDataValidation = authDataValidation.checkFormValidity(
              authDataValidation, _mountValidationFields())
        });
    final imageValid =
        _authData.isLogin ? true : authDataValidation.fields['image']!.valid;
    
    final bool isvalidForm = _formKey.currentState!.validate() && imageValid;
    if (!isvalidForm) return;
    widget.onSubmit(_authData);
    //pass back to page
  }

  @override
  Widget build(BuildContext context) {
    final formType = _authData.isLogin ? 'login' : 'signup';
    authDataValidation =
        FormValidation(fields: (auth_form_validation[formType]!));
    return Card(
        margin: const EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (_authData.isSignup)
                    UserImagePicker(onImagePicked: _imagePick),
                  if (_authData.isSignup)
                    TextFormField(
                      key: const ValueKey('name'),
                      initialValue: _authData.name,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (name) => {
                        _authData.name = name,
                        setState(() => {
                              authDataValidation =
                                  authDataValidation.checkFieldValidity(
                                      fieldName: 'name', value: name)
                            })
                      },
                      validator: (_) {
                        final field = authDataValidation.fields['name']!;
                        if (!field.valid && field.touched) {
                          return authDataValidation.fields['name']!.error;
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                    ),
                  TextFormField(
                    key: const ValueKey('email'),
                    initialValue: _authData.email,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (email) => {
                      _authData.email = email,
                      setState(() => {
                            authDataValidation =
                                authDataValidation.checkFieldValidity(
                                    fieldName: 'email', value: email)
                          })
                    },
                    validator: (_) {
                      final field = authDataValidation.fields['email']!;
                      if (!field.valid && field.touched) {
                        return authDataValidation.fields['email']!.error;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                    ),
                  ),
                  TextFormField(
                    key: const ValueKey('password'),
                    obscureText: true,
                    initialValue: _authData.password,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (password) => {
                      _authData.password = password,
                      setState(() => {
                            authDataValidation =
                                authDataValidation.checkFieldValidity(
                                    fieldName: 'password', value: password)
                          })
                    },
                    validator: (_) {
                      final field = authDataValidation.fields['password']!;
                      if (!field.valid && field.touched) {
                        return authDataValidation.fields['password']!.error;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(_authData.isLogin ? 'Entrar' : 'Cadastre-se'),
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _authData.toggleAuthMode();
                      });
                    },
                    child: Text(_authData.isLogin
                        ? 'Criar uma nova conta?'
                        : 'Entra com minha conta!'),
                  ),
                  const SizedBox(height: 15),
                  // Text(
                  //   'teste ${authDataValidation.valid.toString()}',
                  //   style: const TextStyle(color: Colors.black),
                  // )
                ],
              )),
        ));
  }
}
