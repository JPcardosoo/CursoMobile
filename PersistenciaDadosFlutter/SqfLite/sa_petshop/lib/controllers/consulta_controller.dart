import 'package:sa_petshop/models/consulta_model.dart';
import 'package:sa_petshop/services/petshop_dbhelper.dart';

class ConsultaController {
  final _dbHelper = PetShopDBHelper();

  //métodos do Crud

  Future<int> createConsulta(Consulta consulta) async {
    return _dbHelper.insertConsulta(consulta);
  }

  Future<List<Consulta>> readConsultasForPet(int petId) async {
    return _dbHelper.getConsultasForPet(petId);
  }

  Future<int> deleteConsulta(int id) async {
    return _dbHelper.deleteConsulta(id);
  }
}
