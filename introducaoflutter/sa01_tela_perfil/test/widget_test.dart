import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo')),
      body: Center(
        child: Text(
          '$_counter', // Exibe o valor do contador
          style:
              Theme.of(context)
                  .textTheme
                  .headlineMedium, // Substituindo headline4 por headlineMedium
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter, // Incrementa o contador ao pressionar
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
