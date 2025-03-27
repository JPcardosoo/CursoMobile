import 'package:flutter/material.dart';
import 'package:sa04_cadatro_3telas/tela_boas_vindas_view.dart';
import 'package:sa04_cadatro_3telas/tela_cadastro_view.dart';
import 'package:sa04_cadatro_3telas/tela_confirmacao_view.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => TelaBoasVindasView(),
        "/cadastro": (context) => TelaCadastro(),
        "/confirmacao": (context) => TelaConfirmacao(),
      },
    ),
  );
}