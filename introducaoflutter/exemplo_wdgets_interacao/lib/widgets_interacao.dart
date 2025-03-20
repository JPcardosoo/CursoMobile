import 'package:flutter/material.dart';

class WidgetsInteracao extends StatefulWidget {
  @override
  _WidgetsInteracaoState createState() => _WidgetsInteracaoState();
}

class _WidgetsInteracaoState extends State<WidgetsInteracao> {
  String _textoExibido = "Texto inicial";

  void _alterarTexto() {
    setState(() {
      _textoExibido = "Texto alterado!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Interação com Widgets")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_textoExibido, style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _alterarTexto,
              child: Text("Alterar Texto"),
            ),
          ],
        ),
      ),
    );
  }
}
