import 'package:flutter/material.dart';
import '../../models/livro.dart';
import '../../controllers/livro_controller.dart';

class LivroFormView extends StatefulWidget {
  final Livro? livro;

  LivroFormView({this.livro});

  @override
  _LivroFormViewState createState() => _LivroFormViewState();
}

class _LivroFormViewState extends State<LivroFormView> {
  final _formKey = GlobalKey<FormState>();
  final LivroController _controller = LivroController();

  late String titulo;
  late String autor;

  @override
  void initState() {
    super.initState();
    titulo = widget.livro?.titulo ?? '';
    autor = widget.livro?.autor ?? '';
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final livro = Livro(id: widget.livro?.id ?? '', titulo: titulo, autor: autor);
      if (widget.livro == null) {
        await _controller.create(livro);
      } else {
        await _controller.update(livro);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.livro == null ? 'Novo Livro' : 'Editar Livro')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: titulo,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) => value!.isEmpty ? 'Informe o título' : null,
                onSaved: (value) => titulo = value!,
              ),
              TextFormField(
                initialValue: autor,
                decoration: InputDecoration(labelText: 'Autor'),
                validator: (value) => value!.isEmpty ? 'Informe o autor' : null,
                onSaved: (value) => autor = value!,
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
