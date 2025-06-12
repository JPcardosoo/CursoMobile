import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sa_petshop/controllers/consulta_controller.dart';
import 'package:sa_petshop/models/consulta_model.dart';

class AgendaConsultaScreen extends StatefulWidget {
  final int petId;

  const AgendaConsultaScreen({super.key, required this.petId});

  @override
  State<StatefulWidget> createState() {
    return _AgendaConsultaScreenState();
  }
}

class _AgendaConsultaScreenState extends State<AgendaConsultaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _consultaController = ConsultaController();

  String _tipoServico = '';
  String _observacao = '';
  DateTime _dataSelecionada = DateTime.now();
  TimeOfDay _horaSelecionada = TimeOfDay.now();

  // Método para Selecionar Data
  _selecionarData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _dataSelecionada) {
      setState(() {
        _dataSelecionada = picked;
      });
    }
  }

  // Método para Selecionar Hora
  _selecionarHora(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _horaSelecionada,
    );
    if (picked != null && picked != _horaSelecionada) {
      setState(() {
        _horaSelecionada = picked;
      });
    }
  }

  // Método para Salvar Consulta
  _salvarAgendamento() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final DateTime dataAgendamento = DateTime(
        _dataSelecionada.year,
        _dataSelecionada.month,
        _dataSelecionada.day,
        _horaSelecionada.hour,
        _horaSelecionada.minute,
      );

      final newConsulta = Consulta(
        petId: widget.petId,
        dataHora: dataAgendamento,
        tipoServico: _tipoServico,
        observacao: _observacao.isEmpty ? "." : _observacao,
      );

      try {
        await _consultaController.createConsulta(newConsulta);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Agendamento Realizado com Sucesso")));
        Navigator.pop(context); // Volta para tela anterior
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Exception: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataFormatada = DateFormat("dd/MM/yyyy").format(_dataSelecionada);
    final horaFormatada = _horaSelecionada.format(context);

    return Scaffold(
      appBar: AppBar(title: Text("Novo Agendamento")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Tipo de Serviço"),
                validator: (value) => value == null || value.isEmpty ? "Campo não Preenchido" : null,
                onSaved: (newValue) => _tipoServico = newValue ?? '',
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _selecionarData(context),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: "Data",
                          border: OutlineInputBorder(),
                        ),
                        child: Text(dataFormatada),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () => _selecionarHora(context),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: "Hora",
                          border: OutlineInputBorder(),
                        ),
                        child: Text(horaFormatada),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: "Observação"),
                onSaved: (newValue) => _observacao = newValue ?? '',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarAgendamento,
                child: Text("Salvar Agendamento"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}