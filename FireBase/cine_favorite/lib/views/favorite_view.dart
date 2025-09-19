import 'package:flutter/material.dart';
import 'login_view.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> favoritos = [
      "Vingadores: Ultimato",
      "Interestelar",
      "Batman: O Cavaleiro das Trevas"
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Favoritos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: favoritos.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.movie),
            title: Text(favoritos[index]),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                
              
              },
            ),
          );
        },
      ),
    );
  }
}
