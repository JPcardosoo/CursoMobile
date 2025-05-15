//  Arquivo para funcionar a conexão com o DataBase (Banco de Dados)
// Instalar os pacotes sqflite path_provider

import 'package:sqflite/sqflite.dart';

class NotaDBhelper {
    static Databasse? _database;

    static const String DB-NAME = "notas.db";
    static const String TABLE-NAME = "notas";
    static const String CREATE-TABLE_SQL = """CREATE TABLE IF NOT EXISTS $TABLE_NAME (
                                          id INTEGER PRIMARY KEY AUTOINCREMENT,
                                          titulo TEXT NOT NULL, 
                                          conteudo TEXT NOT NULL)""";

// Métodos
//Iniciar conexão
Future<Database> get database async {
    if (_database != null){
        return _database!;
    }
    _database = await _initDataBase();
    return _database!;
}

Future<Database> _initDataBase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DB_NAME);
    return await openDatabase(
        path, onCreate: (db, version) {
            await db.execute(CREATE_TABLE_SQL);
        },
        version: 1,
    );
}
}