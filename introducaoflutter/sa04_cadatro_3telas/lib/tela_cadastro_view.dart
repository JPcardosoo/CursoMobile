import 'package:flutter/material.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>(); // FormKey para validação
  String _nome = '';
  String _email = '';
  final String _senha = '';
  String _genero = '';
  String _dataNascimento = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro de Usuário"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo Nome
              TextFormField(
                decoration: InputDecoration(labelText: "Digite seu Nome"),
                validator:
                    (value) =>
                        value!.isEmpty ? "Campo não Preenchido!!!" : null,
                onSaved: (value) => _nome = value!,
              ),
              SizedBox(height: 20),

              // Campo Email
              TextFormField(
                decoration: InputDecoration(labelText: "Digite seu Email"),
                validator:
                    (value) =>
                        value!.contains("@") ? null : "Digite um e-mail válido",
                onSaved: (value) => _email = value!,
              ),

              // Campo Gênero
              Text("Gênero: "),
              DropdownButtonFormField<String>(
                items:
                    ["Masculino", "Feminino", "Outro"]
                        .map(
                          (String genero) => DropdownMenuItem<String>(
                            value: genero,
                            child: Text(genero),
                          ),
                        )
                        .toList(),
                onChanged: (value) => setState(() => _genero = value!),
                validator:
                    (value) => value == null ? "Selecione um Gênero" : null,
                onSaved: (value) => _genero = value!,
              ),

              TextFormField(
                decoration: InputDecoration(labelText: "Data de Nascimento"),
                validator:
                    (value) =>
                        value!.isEmpty ? "Informe a Data de Nascimento" : null,
                onSaved: (value) => _dataNascimento = value!,
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pushNamed(context, "/confirmacao");
                  }
                },
                child: Text("Enviar"),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/");
                },
                child: Text("Voltar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
