import 'package:flutter/material.dart';
import '../../models/usuario.dart';
import '../../controllers/usuario_controller.dart';
import 'usuario_form_view.dart';

class UsuarioListView extends StatefulWidget {
  @override
  _UsuarioListViewState createState() => _UsuarioListViewState();
}

class _UsuarioListViewState extends State<UsuarioListView> {
  final UsuarioController _controller = UsuarioController();
  List<Usuario> usuarios = [];

  @override
  void initState() {
    super.initState();
    _loadUsuarios();
  }

  void _loadUsuarios() async {
    var data = await _controller.fetchAll();
    setState(() {
      usuarios = data;
    });
  }

  void _deleteUsuario(String id) async {
    await _controller.delete(id);
    _loadUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuários'),
      ),
      body: ListView.builder(
        itemCount: usuarios.length,
        itemBuilder: (context, index) {
          final usuario = usuarios[index];
          return ListTile(
            title: Text(usuario.nome),
            subtitle: Text(usuario.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => UsuarioFormView(usuario: usuario)),
                    ).then((_) => _loadUsuarios());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteUsuario(usuario.id);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => UsuarioFormView()),
          ).then((_) => _loadUsuarios());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
