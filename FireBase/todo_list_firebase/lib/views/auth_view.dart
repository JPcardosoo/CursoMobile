import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_firebase/views/login_view.dart';
import 'package:todo_list_firebase/views/tarefas_view.dart';

// Tela autenticação de Usuário Já Cadastrado
class AuthView extends StatelessWidget {
  
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<User?>( // Identifica se tem um usuario cadastrado no cache instantaneamente
      stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (context, snapshot){ // Usa os dados do cache para decidir
        if(snapshot.hasData){ // Se tiver dados vai para Tarefas 
          return TarefasView();
        }// Se não tiver dados no cache vai para Login
        return LoginView();
      });
  }
}