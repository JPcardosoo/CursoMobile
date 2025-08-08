import 'dart:convert';

void main() {
  // String no Formato Json ->
  String jsonString = '''{"usuario": "João",  
                          "login": "joao_user",
                          "senha": 1234
                          "ativo": true
                         }''';
  // Converti a String em MAP -> usando Json. Cnvert (decode)
  Map<String, dynamic> usuario = json.decode(jsonString);
  // Acesso aos elementos(atributos) do Json
  print(usuario["ativo"]);

  // Manipular Json usando o MAP
  usuario["ativo"] = false;

  // Fazer o encode Map => Json(texto);

  // Mostrar o texto no formato Json
  print(usuario["ativo"]);
}
