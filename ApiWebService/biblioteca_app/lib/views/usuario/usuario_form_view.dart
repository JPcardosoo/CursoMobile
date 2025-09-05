import 'package:flutter/material.dart';
import '../../models/usuario.dart';
import '../../controllers/usuario_controller.dart';

class UsuarioFormView extends StatefulWidget {
  final Usuario? usuario;

  UsuarioFormView({this.usuario});

  @override
  _UsuarioFormViewState createState() => _UsuarioFormViewState();
}

class _UsuarioFormViewState extends State<UsuarioFormView> {
  final _formKey = GlobalKey<FormState>();
  final UsuarioController _controller = UsuarioController();

  late String nome;
  late String email;

  @override
  void initState() {
    super.initState();
    nome = widget.usuario?.nome ?? '';
    email = widget.usuario?.email ?? '';
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final usuario = Usuario(id: widget.usuario?.id ?? '', nome: nome, email: email);
      if (widget.usuario == null) {
        await _controller.create(usuario);
      } else {
        await _controller.update(usuario);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.usuario == null ? 'Novo Usuário' : 'Editar Usuário')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: nome,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) => value!.isEmpty ? 'Informe o nome' : null,
                onSaved: (value) => nome = value!,
              ),
              TextFormField(
                initialValue: email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Informe o email' : null,
                onSaved: (value) => email = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _save,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
