// Classe de ajuda para conexão com o db

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PetDBHelper { // Fazer conexão singleton
    static Database? _database; // obj SQlite conexão com DB
    static final PetShopDBHelper = _instance = PetDBHelper()._internal();

    PetShopDBHelper._internal();
    factory PesDBHelper() {
        return _instance;
    }
    
    // Verificação do bancao de dados -> verificar se já foi criado, e se esta bem aberto
    Future<Database> _initDatabase() async {
        final dbPath = await getDatabasePath();
        final path = join(dbPath, "petshop.db");

        return await openDatabase(
            path,
            onCreate: (db,version) async {
                await db.execute(
                    '''
                    CREATE TABLE IF NOT EXISTS pet(
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        nome TEXT NOT NULL,
                        raca TEXT NOT NULL,
                        nome_dono TEXT NOT NULL,
                        telefone_dono TEXT NOT NULL
                    ); 
                    '''// Continuação para criação da tabela consulta
                );},
                version: 1;
        );
    }

    Future<Database> get database async {
        if (_database != null) {
            return _database!;
        }else {
            _database = await _initDatabase();
            return _database!;
        }
    }

    // Métodos do CRUD - PETS
    Future<int> insertPet(Pet pet) async {
        final db = await database; // Verificar a conexão
        return db.insert("pets", pet.toMap()); // Inserir o dado no banco de dados
    } 

    Future<List<Pet>> getPets() async {
        final db = await database; // Verificar a conexão 
        final List<Map<String, dynamic>> maps = await db.query("pets"); // Pegar os dados do banco de dados
        return maps.map((e) => Pet.fromMap(e)).toList(); // Factory do DB -> obj
    }

    Future<int?> getPetById(int id) async {
        final db = await database;
        final List<Map<String, dynamic>> maps = await db.query(
            "pets",
            where: "id=?",
            whereArgs: [id]);
        if (maps.isEmpty) {
            return null;
        } else {
            Pet.fromMap(maps.first);
        }
        return null;
    }

    Future<int> deletePet(int id) async {
        final db = await database;
        return await db.delete("pets", where: "id=?", whereArgs: [id]);
    } // DELETE ON CASCADE na tabela Consulta
}