import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MeuPerfilApp());
}

class MeuPerfilApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Perfil Persistente',
      home: MeuPerfilPage(),
    );
  }
}

class MeuPerfilPage extends StatefulWidget {
  @override
  _MeuPerfilPageState createState() => _MeuPerfilPageState();
}

class _MeuPerfilPageState extends State<MeuPerfilPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();

  String _corFavorita = 'Azul';
  final List<String> _cores = ['Azul', 'Verde', 'Vermelho', 'Amarelo'];

  String _nomeSalvo = '';
  String _idadeSalva = '';
  String _corSalva = 'Azul';

  final Map<String, Color> _coresMap = {
    'Azul': Colors.blue,
    'Verde': Colors.green,
    'Vermelho': Colors.red,
    'Amarelo': Colors.yellow,
  };

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final prefs = await SharedPreferences.getInstance();
    _nomeSalvo = prefs.getString('nome') ?? '';
    _idadeSalva = prefs.getString('idade') ?? '';
    _corSalva = prefs.getString('cor') ?? 'Azul';

    setState(() {
      _nomeController.text = _nomeSalvo;
      _idadeController.text = _idadeSalva;
      _corFavorita = _corSalva;
    });
  }

  Future<void> _salvarDados() async {
    if (_nomeController.text.isEmpty || _idadeController.text.isEmpty) {
      _mostrarMensagem('Por favor, preencha todos os campos!');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome', _nomeController.text);
    await prefs.setString('idade', _idadeController.text);
    await prefs.setString('cor', _corFavorita);

    _mostrarMensagem('Dados salvos com sucesso!');
    _carregarDados();
  }

  void _mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _coresMap[_corSalva],
      appBar: AppBar(
        title: Text('Meu Perfil Persistente'),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Nome', _nomeController),
            SizedBox(height: 10),
            _buildTextField('Idade', _idadeController, isNumber: true),
            SizedBox(height: 10),
            _buildDropdown(),
            SizedBox(height: 20),
            _buildSalvarButton(),
            SizedBox(height: 30),
            _buildDadosSalvos(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isNumber = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: _corFavorita,
      items: _cores.map((String cor) {
        return DropdownMenuItem<String>(
          value: cor,
          child: Text(cor),
        );
      }).toList(),
      onChanged: (novaCor) {
        setState(() {
          _corFavorita = novaCor!;
        });
      },
      decoration: InputDecoration(
        labelText: 'Cor Favorita',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildSalvarButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _salvarDados,
        child: Text('Salvar Dados'),
      ),
    );
  }

  Widget _buildDadosSalvos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dados Salvos:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('Nome: $_nomeSalvo'),
        Text('Idade: $_idadeSalva'),
        Text('Cor Favorita: $_corSalva'),
      ],
    );
  }
}