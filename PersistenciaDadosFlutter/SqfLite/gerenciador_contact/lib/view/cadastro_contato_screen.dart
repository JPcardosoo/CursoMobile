import 'package:flutter/material.dart';
import '../controllers/contact_controller.dart';
import '../models/contact_model.dart';
import '../models/contact_field_model.dart';
import 'home_contato_screen.dart'; 

class CadastroContatoScreen extends StatefulWidget {
  const CadastroContatoScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CadastroContatoScreenState();
}

class _CadastroContatoScreenState extends State<CadastroContatoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controllerContato = ContactController();

  late String _nome;
  late String _telefone;
  String? _email;

  final List<ContactField> _camposAdicionais = [];

  void _adicionarCampoAdicional() async {
    String tipo = '';
    String valor = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Adicionar Campo Adicional"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Tipo (ex: Endereço, Aniversário)"),
              onChanged: (v) => tipo = v,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Valor"),
              onChanged: (v) => valor = v,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (tipo.isNotEmpty) {
                setState(() {
                  _camposAdicionais.add(ContactField(
                    contactId: 0, 
                    tipo: tipo,
                    valor: valor,
                  ));
                });
              }
              Navigator.pop(context);
            },
            child: Text("Adicionar"),
          ),
        ],
      ),
    );
  }

  Future<void> _salvarContato() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final novoContato = Contact(
        nome: _nome,
        telefone: _telefone,
        email: _email,
      );
      int contatoId = await _controllerContato.createContact(novoContato);
      for (var campo in _camposAdicionais) {
        await _controllerContato.addContactField(
          campo.copyWith(contactId: contatoId),
        );
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeContatoScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Novo Contato")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Nome"),
                validator: (value) => value!.isEmpty ? "Campo não Preenchido!!!" : null,
                onSaved: (value) => _nome = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Telefone"),
                validator: (value) => value!.isEmpty ? "Campo não Preenchido!!!" : null,
                onSaved: (value) => _telefone = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "E-mail"),
                onSaved: (value) => _email = value,
              ),
              SizedBox(height: 20),
              Text("Campos Adicionais:", style: TextStyle(fontWeight: FontWeight.bold)),
              ..._camposAdicionais.map((campo) => ListTile(
                    title: Text("${campo.tipo}: ${campo.valor}"),
                  )),
              TextButton.icon(
                onPressed: _adicionarCampoAdicional,
                icon: Icon(Icons.add),
                label: Text("Adicionar Campo"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarContato,
                child: Text("Cadastrar Contato"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}