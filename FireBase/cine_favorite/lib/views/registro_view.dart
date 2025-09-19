import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegistroView extends StatefulWidget {
  const RegistroView({super.key});

  @override
  State<RegistroView> createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  void _registrar() {
    final email = _emailController.text.trim();
    final senha = _senhaController.text.trim();

    final sucesso = AuthService.registrar(email, senha);

    if (sucesso) {
      Navigator.pop(context); // volta para tela de login
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Conta criada com sucesso!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuário já existe")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _senhaController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Senha"),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _registrar,
              child: const Text("Registrar"),
            ),
          ],
        ),
      ),
    );
  }
}
