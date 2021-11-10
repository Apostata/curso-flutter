import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/errors/auth_exception.dart';
import 'package:shop/providers/auth.provider.dart';

enum EAuthMode { Singup, Login }

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  EAuthMode _authMode = EAuthMode.Login;
  final Map<String, String> _formData = {'email': '', 'password': ''};
  final _passwordControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );
  late final Animation<double> _animationOpacity =
      Tween(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ),
  );

  late final Animation<Offset> _animationSlide =
      Tween<Offset>(begin: const Offset(0, -1.5), end: const Offset(0, 0))
          .animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ),
  );

  Future<void> _submit() async {
    final isValidForm = _formKey.currentState?.validate() ?? false;

    if (!isValidForm) return;

    setState(() => _isLoading = true);
    _formKey.currentState?.save();
    try {
      await Provider.of<Auth>(context, listen: false)
          .authenticate(_formData, _isSignup());
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    } finally {
      setState(() => _isLoading = false);
    }

    setState(() => _isLoading = false);
  }

  bool _isLogin() => _authMode == EAuthMode.Login;

  bool _isSignup() => _authMode == EAuthMode.Singup;

  bool _isValalidEmail(String email) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return emailRegex.hasMatch(email);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _switchAuthMode() {
    if(_isLogin()){
       _controller.forward();

      setState(() {
        _authMode = EAuthMode.Singup;
      });
    } else{
      _controller.reverse();
      
      Timer(const Duration(milliseconds: 300), () {
          setState(() {
            _authMode = EAuthMode.Login;
          });
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
      // height: _isLogin() ? 320 : 400,
      height: _isLogin() ? 330 : 400,
      width: deviceSize.width * 0.75,
      constraints: const BoxConstraints(
        maxWidth: 375,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10,
            offset: Offset(0, 4),
            spreadRadius: -1.0,
          )
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (_email) {
                    final email = _email ?? '';
                    if (!_isValalidEmail(email)) {
                      return 'Email inválido!';
                    }
                    return null;
                  },
                  onSaved: (email) => {_formData['email'] = email ?? ''},
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  controller: _passwordControler,
                  validator: (_password) {
                    final password = _password ?? '';
                    if (password.isEmpty) {
                      return 'É necessário criar uma senha!';
                    } else if (password.length < 5) {
                      return 'A senha deve ter no mínimo 5 Caracteres!';
                    }
                    return null;
                  },
                  onSaved: (password) =>
                      {_formData['password'] = password ?? ''},
                ),
                if (!_isLogin())
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                    constraints: BoxConstraints(
                        minHeight: _isLogin() ? 0 : 60,
                        maxHeight: _isLogin() ? 0 : 120),
                    child: FadeTransition(
                      opacity: _animationOpacity,
                      child: SlideTransition(
                        position: _animationSlide,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Confirmar Senha',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          obscureText: true,
                          validator: _isLogin()
                              ? null
                              : (confirmPassword) {
                                  final password = confirmPassword ?? '';
                                  if (password != _passwordControler.text ||
                                      _passwordControler.text.isEmpty) {
                                    return 'Senhas informadas não conferem';
                                  }
                                  return null;
                                },
                        ),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _submit,
                        child: Text(_isLogin() ? 'ENTRAR' : 'REGISTRAR'),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 30)),
                      ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    _switchAuthMode();
                  },
                  child: Text(_isLogin()
                      ? 'Não possui uma conta? Registre-se!'
                      : 'Já possui uma conta?'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
