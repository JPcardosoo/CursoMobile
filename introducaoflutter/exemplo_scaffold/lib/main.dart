import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Exemplo de Scaffold'),
          backgroundColor: const Color.fromARGB(255, 95, 94, 94),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              Text("Ínicio"),
              Text("Conteúdo"),
              Text("Contato"),
            ],
          ),
        ),
        body: Center(
          child: Text('Conteúdo da tela', style: TextStyle(fontSize: 20)),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('Botão pressionado!');
          },
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'), 
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),            
          ],
        ),
      ),
    );
  }
}
