import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistroView extends StatefulWidget {
  const RegistroView({super.key});

  @override
  State<RegistroView> createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  // Atributos
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailField = TextEditingController();
  final _senhaField = TextEditingController();
  final _confirmarSenhaField = TextEditingController();

  void _registrar() async {
    if (_senhaField.text != _confirmarSenhaField.text) return;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailField.text.trim(),
        password: _senhaField.text,
      );
      // Após o registro, o usuário já é logado no sistema
      // AuthView -> Joga ele pra tela de Tarefas
    } on FirebaseAuthException catch (e) {
      // Erro especificos do FirebaseAuth
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao Registrar: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailField,
              decoration: const InputDecoration(labelText: "E-mail",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _senhaField,
              decoration: const InputDecoration(labelText: "Senha",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _confirmarSenhaField,
              decoration: const InputDecoration(labelText: "Confirmar Senha",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 23),
            ElevatedButton(onPressed: _registrar, child: const Text("Registrar"),
            ),
          ],
        ),
      ),
    );
  }
}
