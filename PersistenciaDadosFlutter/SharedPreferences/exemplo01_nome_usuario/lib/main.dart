import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(home: UserNamePage()));
}

// Classe da página
class UserNamePage extends StatefulWidget {
  const UserNamePage({super.key});

  @override
  _UserNamePageState createState() => _UserNamePageState();
}

class _UserNamePageState extends State<UserNamePage> {
  final TextEditingController _controller = TextEditingController();
  String _nomeSalvo = '';

  @override
  void initState() {
    super.initState();
    _carregarNomeSalvo();
  }

  void _carregarNomeSalvo() async {
    // Usar o SharedPreferences para carregar as info salvas
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nomeSalvo = prefs.getString('nome') ?? "";
    });
  }

  void _salvarNome() async {
    // Usar o SharedPreferences para salvar as info
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("nome", _controller.text);
    _carregarNomeSalvo(); // Atualiza a tela
    _controller.clear(); // Limpa o campo de texto
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Salvar nome com SharedPreferences")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller, // corrigido aqui
              decoration: InputDecoration(labelText: "Digite seu nome"),
            ),
            SizedBox(height: 20), // corrigido aqui
            ElevatedButton(onPressed: _salvarNome, child: Text("Salvar")),
            SizedBox(height: 20),
            Text("Nome salvo: $_nomeSalvo", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
