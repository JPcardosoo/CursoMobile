import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:contact_manager/main.dart';

void main() {
  testWidgets('App carrega e mostra o título', (WidgetTester tester) async {
    // Monta o app principal
    await tester.pumpWidget(const MyApp());

    // Verifica se o título padrão aparece na tela
    expect(find.text('Contatos'), findsOneWidget);
  });
}