import 'package:flutter/material.dart';
import '../controllers/contact_controller.dart';
import '../models/contact_model.dart';
import '../models/contact_field_model.dart';

class DetalheContatoScreen extends StatefulWidget {
  final int contatoId;

  const DetalheContatoScreen({super.key, required this.contatoId});

  @override
  State<StatefulWidget> createState() => _DetalheContatoScreenState();
}

class _DetalheContatoScreenState extends State<DetalheContatoScreen> {
  final ContactController _contactController = ContactController();

  bool _isLoading = true;
  Contact? _contato;
  List<ContactField> _camposAdicionais = [];

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    setState(() => _isLoading = true);
    try {
      _contato = await _contactController.readContactById(widget.contatoId);
      _camposAdicionais = await _contactController.readFieldsForContact(widget.contatoId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Exception: $e"))
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

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
              decoration: InputDecoration(labelText: "Observações"),
              onChanged: (v) => valor = v,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (tipo.isNotEmpty) {
                await _contactController.addContactField(
                  ContactField(contactId: widget.contatoId, tipo: tipo, valor: valor),
                );
                Navigator.pop(context);
                _carregarDados();
              }
            },
            child: Text("Adicionar"),
          ),
        ],
      ),
    );
  }

  void _deleteCampoAdicional(int campoId) async {
    try {
      await _contactController.deleteContactField(campoId);
      _carregarDados();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Campo deletado com sucesso"))
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Exception: $e"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalhe do Contato")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _contato == null
              ? Center(child: Text("Erro ao carregar o contato."))
              : Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nome: ${_contato!.nome}", style: TextStyle(fontSize: 20)),
                      Text("Telefone: ${_contato!.telefone}"),
                      Text("E-mail: ${_contato!.email ?? '-'}"),
                      Divider(),
                      Text("Campos Adicionais:", style: TextStyle(fontSize: 20)),
                      _camposAdicionais.isEmpty
                          ? Center(child: Text("Nenhum campo adicional."))
                          : Expanded(
                              child: ListView.builder(
                                itemCount: _camposAdicionais.length,
                                itemBuilder: (context, index) {
                                  final campo = _camposAdicionais[index];
                                  return Card(
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    child: ListTile(
                                      title: Text("${campo.tipo}: ${campo.valor}"),
                                      trailing: IconButton(
                                        onPressed: () => _deleteCampoAdicional(campo.id!),
                                        icon: Icon(Icons.delete, color: Colors.red),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarCampoAdicional,
        tooltip: "Adicionar Campo Adicional",
        child: Icon(Icons.add),
      ),
    );
  }
}