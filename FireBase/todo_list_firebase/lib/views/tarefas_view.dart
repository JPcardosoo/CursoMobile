import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TarefasView extends StatefulWidget {
  const TarefasView({super.key});

  @override
  State<TarefasView> createState() => _TarefasViewState();
}

class _TarefasViewState extends State<TarefasView> {
  // Atributos
  final _db = FirebaseFirestore
      .instance; // Controlador do FireStore(envia as tarefas para o BD)
  final User? _user =
      FirebaseAuth.instance.currentUser; // Pega o usuário logado
  final _tarefasField = TextEditingController(); // Pegar o título da tarefa

  // Métodos

  // Adicionar Tarefa
  void _addTarefa() async {
    if (_tarefasField.text.trim().isEmpty)
      return; // Não continua se campo de tarefa for null
    // Adicionar a tarefa no banco do firestore
    try {
      await _db
          .collection("usuarios")
          .doc(_user!.uid)
          .collection("tarefas")
          .add({
            "titulo": _tarefasField.text.trim(),
            "concluida": false,
            "dataCriacao": Timestamp.now(), // Carimbo de dataehora
          });
      _tarefasField.clear();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao Cadastrar Tarefas $e")));
    }
  }

  // Atualizar tarefa
  void _atualizarTarefa(String id, bool statusAtual) async {
    try {
      await _db
          .collection("usuarios")
          .doc(_user!.uid)
          .collection("tarefas")
          .doc(id)
          .update({"concluida": !statusAtual});
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao Atualizar Tarefas $e")));
    }
  }

  // Deletar tarefa
  void _deletarTarefa(String tarefaId) async {
    try {
      await _db
          .collection("usuarios")
          .doc(_user!.uid)
          .collection("tarefas")
          .doc(tarefaId)
          .delete();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao deletar tarefa: $e")));
    }
  }

  // Build da Tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Tarefas"),
        actions: [
          IconButton(
            onPressed: FirebaseAuth.instance.signOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      // Body das tarefas
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tarefasField,
              decoration: InputDecoration(
                labelText: "Nova Tarefa",
                border: OutlineInputBorder(),
                suffix: IconButton(
                  onPressed: _addTarefa,
                  icon: Icon(Icons.add),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Construir a lista de tarefas StreamBuilder
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _db
                    .collection("usuarios")
                    .doc(_user?.uid)
                    .collection("tarefas")
                    .orderBy("dataCriacao", descending: true)
                    .snapshots(), // Le a modificação da lista de tarefas
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("Nenhuma Tarefa Encontrada"));
                  }
                  final tarefas = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: tarefas.length,
                    itemBuilder: (context, index) {
                      final tarefa = tarefas[index];
                      // Convert Texto/Json em Map<String, dynamic>
                      final tarefaMap = tarefa.data() as Map<String, dynamic>;
                      // Ajustar a boolean
                      bool concluida = tarefaMap["concluida"] ?? false;
                      return ListTile(
                        // Para cada item da lista adicione um ListTile
                        title: Text(tarefaMap["titulo"]),
                        leading: Checkbox(
                          value: concluida,
                          onChanged: (value) =>
                              _atualizarTarefa(tarefa.id, concluida),
                        ),
                        trailing: IconButton(
                          onPressed: () => _deletarTarefa(tarefa.id),
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
