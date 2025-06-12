import 'package:flutter/material.dart';
import '../controllers/contact_controller.dart';
import '../models/contact_model.dart';
import 'cadastro_contato_screen.dart';
import 'detalhe_contato_screen.dart';

class HomeContatoScreen extends StatefulWidget {
  const HomeContatoScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeContatoScreenState();
}

class _HomeContatoScreenState extends State<HomeContatoScreen> {
  final ContactController _controllerContato = ContactController();
  List<Contact> _contatos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() async {
    setState(() {
      _isLoading = true;
    });
    _contatos = [];
    try {
      _contatos = await _controllerContato.readContacts();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao carregar os dados: $e"))
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _deleteContato(int id) async {
    try {
      await _controllerContato.deleteContact(id);
      _carregarDados();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Contato deletado com sucesso"))
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
      appBar: AppBar(title: Text("Meus Contatos")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: _contatos.length,
                itemBuilder: (context, index) {
                  final contato = _contatos[index];
                  return ListTile(
                    title: Text(contato.nome),
                    subtitle: Text(contato.telefone + (contato.email != null && contato.email!.isNotEmpty ? " - ${contato.email}" : "")),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalheContatoScreen(contatoId: contato.id!),
                      ),
                    ).then((_) => _carregarDados()),
                    onLongPress: () => _deleteContato(contato.id!),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CadastroContatoScreen()),
        ).then((_) => _carregarDados()),
        tooltip: "Adicionar Novo Contato",
        child: Icon(Icons.add),
      ),
    );
  }
}