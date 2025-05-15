

class NotasController {
    final NotaDBhelper _dBhelper = NotaDBhelper();

    // 4 métodos do crud

    Future<List<Nota>> getNotas() async {
        return await _dBhelper.getNotas();
    }

    Future<int> addNota(Nota nota) async {
        return await _dBhelper.insertNota(nota);
    }

    Future<int> updateNota(int id) async {
        return await _dBhelper.updateNota(id);
    }

    Future<int> deleteNota(int id) async {
        return await _dBhelper.deleteNota(id);
    }
}