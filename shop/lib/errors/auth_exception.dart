class AuthException implements Exception {
  final Map<String, String> errors = {
    'EMAIL_EXISTS': 'E-mail já cadastrado.',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida!',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'Muitas tentativas. Acesso temporariamente bloqueado! Tente novamente mais tarde',
    'EMAIL_NOT_FOUND': 'E-mail não encontrado!',
    'INVALID_PASSWORD': 'Email ou senha não conferem',
    'USER_DISABLED': 'Esta conta de usuário foi desabilitada',
  };
  final String key;

  AuthException(this.key);

  @override
  String toString() {
    print(key);
    print(errors[key]);
    return errors[key] ?? 'Ocorreu um erro no processo de autenticação!';
  }
}
