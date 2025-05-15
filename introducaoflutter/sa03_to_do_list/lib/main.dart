import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: ListaTarefas()));
}

class ListaTarefas extends StatefulWidget {
  const ListaTarefas({super.key});

  @override
  _ListaTarefasState createState() => _ListaTarefasState();
}

class _ListaTarefasState extends State<ListaTarefas> {
  final TextEditingController _tarefaController = TextEditingController();
  final List<Map<String, dynamic>> _tarefas = [];

  // Função para exibir SnackBar
  void _mostrarSnackBar(String mensagem) {
    final snackBar = SnackBar(content: Text(mensagem));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Função para adicionar tarefas
  void _adicionarTarefas() {
    if (_tarefaController.text.trim().isNotEmpty) {
      setState(() {
        _tarefas.add({"titulo": _tarefaController.text, "concluida": false});
        _tarefaController.clear();
      });
      _mostrarSnackBar('Tarefa adicionada!');
    }
  }

  // Função para remover tarefas concluídas
  void _removerTarefa() {
    setState(() {
      _tarefas.removeWhere((tarefa) => tarefa['concluida']);
    });
    _mostrarSnackBar('Tarefas concluídas removidas!');
  }

  // Construir estrutura de widget
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("Lista de Tarefas")),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _tarefaController,
            decoration: InputDecoration(labelText: "Digite uma Tarefa"),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _adicionarTarefas,
            child: Text("Adicionar Tarefa"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tarefas.length,
              itemBuilder:
                  (context, index) => ListTile(
                    title: Text(
                      _tarefas[index]["titulo"],
                      style: TextStyle(
                        decoration:
                            _tarefas[index]["concluida"]
                                ? TextDecoration.lineThrough
                                : null,
                      ),
                    ),
                    leading: Checkbox(
                      value: _tarefas[index]["concluida"],
                      onChanged: (bool? valor) {
                        setState(() {
                          _tarefas[index]["concluida"] = valor!;
                        });
                        if (_tarefas[index]["concluida"]) {
                          _mostrarSnackBar(
                            'Tarefa "${_tarefas[index]["titulo"]}" concluída!',
                          );
                        }
                      },
                    ),
                  ),
            ),
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: _removerTarefa,
      child: Icon(Icons.recycling),
    ),
  );
}
