// Classe de controller

import 'package:biblioteca_app/models/usuario.dart';
import 'package:biblioteca_app/services/api_service.dart';

class UsuarioController {
  // Atributos e métodos do controller
  // Get do Usuário
  Future<List<Usuario>> fetchAll() async {
    // Pega a lista de usuario no formato List<dynamic>
    final list = await ApiService.getList("usuarios?_sort=name");
    // Retornar a Lista de Usuários Convertidas
    return list.map((item) => Usuario.fromJson(item)).toList();
  }

  // Get de um unico Usuário
  Future<Usuario> fetchById(String id) async {
    final Usuario = await ApiService.getOne("usuario", id);
    return Usuario.fromJson(Usuario);
  }
  //Post -> Criar um Novo usuário

  //Put -. Alterar um Usuário

  // Delete -> Deletar um Usuário
}
