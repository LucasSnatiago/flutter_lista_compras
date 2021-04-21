import 'package:dbcrypt/dbcrypt.dart';

/// Hashear uma senha para salvar no banco de dados
String hashedPassword(String senha) {
  return new DBCrypt().hashpw(senha, new DBCrypt().gensalt());
}

/// Verificar se uma senha hasheada é igual a senha do banco
bool checkPassword(String senha, String senhaHasheada) {
  return new DBCrypt().checkpw(senha, senhaHasheada);
}
