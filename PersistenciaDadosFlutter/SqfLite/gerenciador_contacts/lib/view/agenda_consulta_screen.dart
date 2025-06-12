import 'package:flutter/material.dart';
import '../controllers/contact_controller.dart';
import '../models/contact_model.dart';
import '../models/contact_field_model.dart';

class CadastroContatoScreen extends StatefulWidget {
  const CadastroContatoScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CadastroContatoScreenState();
}

class _CadastroContatoScreenState extends State<CadastroContatoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _contactController = ContactController();

  String _nome = '';
  String _telefone = '';
  String _email = '';
  final List<ContactField> _camposAdicionais = [];

  // Adiciona campo extra
  void _adicionarCampoAdicional() async {
    String tipo = '';
    String valor = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Campo Adicional"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Tipo (ex: Outro telefone, Endereço, Aniversário)"),
              onChanged: (v) => tipo = v,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "observações"),
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
                    contactId: 0, // será atualizado após salvar o contato
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

  // Salva o contato e os campos adicionais
  Future<void> _salvarContato() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final novoContato = Contact(nome: _nome, telefone: _telefone, email: _email.isEmpty ? null : _email);
      try {
        int contatoId = await _contactController.createContact(novoContato);
        for (var campo in _camposAdicionais) {
          await _contactController.addContactField(
            campo.copyWith(contactId: contatoId),
          );
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Contato salvo com sucesso!")),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro: $e")),
        );
      }
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
                validator: (value) => value == null || value.isEmpty ? "Campo obrigatório" : null,
                onSaved: (v) => _nome = v ?? '',
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: "Telefone"),
                validator: (value) => value == null || value.isEmpty ? "Campo obrigatório" : null,
                onSaved: (v) => _telefone = v ?? '',
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: "E-mail"),
                onSaved: (v) => _email = v ?? '',
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
                child: Text("Salvar Contato"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}