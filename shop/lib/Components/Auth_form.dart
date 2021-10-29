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

class _AuthFormState extends State<AuthForm> {
  EAuthMode _authMode = EAuthMode.Login;
  final Map<String, String> _formData = {'email': '', 'password': ''};
  final _passwordControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _submit() async {
    final isValidForm = _formKey.currentState?.validate() ?? false;

    if (!isValidForm) return;

    setState(() => _isLoading = true);
    _formKey.currentState?.save();
    try {
      final auth = await Provider.of<Auth>(context, listen: false)
          .authenticate(_formData, isSignup());
    } on AuthException catch (error) {
         ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString())
          )
        );
    } finally {
      setState(() => _isLoading = false);
    }

    setState(() => _isLoading = false);
  }

  bool isLogin() => _authMode == EAuthMode.Login;

  bool isSignup() => _authMode == EAuthMode.Singup;

  bool isValalidEmail(String email) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: isLogin() ? 320 : 400,
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
          ]),
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
                    if (!isValalidEmail(email)) {
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
                if (_authMode == EAuthMode.Singup)
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Confirmar Senha',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    validator: isLogin()
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
                const SizedBox(
                  height: 20,
                ),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _submit,
                        child: Text(isLogin() ? 'ENTRAR' : 'REGISTRAR'),
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
                    setState(() {
                      _authMode =
                          isLogin() ? EAuthMode.Singup : EAuthMode.Login;
                    });
                  },
                  child: Text(isLogin()
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
