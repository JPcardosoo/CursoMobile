import 'package:flutter/material.dart';
import '../../models/livro.dart';
import '../../controllers/livro_controller.dart';
import 'livro_form_view.dart';

class LivroListView extends StatefulWidget {
  @override
  _LivroListViewState createState() => _LivroListViewState();
}

class _LivroListViewState extends State<LivroListView> {
  final LivroController _controller = LivroController();
  List<Livro> livros = [];

  @override
  void initState() {
    super.initState();
    _loadLivros();
  }

  void _loadLivros() async {
    var data = await _controller.fetchAll();
    setState(() {
      livros = data;
    });
  }

  void _deleteLivro(String id) async {
    await _controller.delete(id);
    _loadLivros();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Livros'),
      ),
      body: ListView.builder(
        itemCount: livros.length,
        itemBuilder: (context, index) {
          final livro = livros[index];
          return ListTile(
            title: Text(livro.titulo),
            subtitle: Text(livro.autor),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LivroFormView(livro: livro)),
                    ).then((_) => _loadLivros());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteLivro(livro.id);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => LivroFormView()),
          ).then((_) => _loadLivros());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
