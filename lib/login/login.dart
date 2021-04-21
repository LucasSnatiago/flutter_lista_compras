import 'package:dbcrypt/dbcrypt.dart';

/// Hashear uma senha para salvar no banco de dados
String hashedPassword(String senha) {
  return new DBCrypt().hashpw(senha, new DBCrypt().gensalt());
}

/// Verificar se uma senha hasheada é igual a senha do banco
bool checkPassword(String senha, String senhaHasheada) {
  return new DBCrypt().checkpw(senha, senhaHasheada);
}

/// Regex simples de validação de email
bool isValidEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}
