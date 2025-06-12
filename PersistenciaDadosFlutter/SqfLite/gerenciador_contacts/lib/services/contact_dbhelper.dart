import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../models/contact_model.dart';
import '../../models/contact_field_model.dart';

class ContactDBHelper {
  static Database? _database;
  static final ContactDBHelper _instance = ContactDBHelper._internal();

  ContactDBHelper._internal();
  factory ContactDBHelper() => _instance;

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "contacts.db");
    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  _onCreateDB(Database db, int version) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS contacts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        telefone TEXT NOT NULL,
        email TEXT
      );
    """);
    await db.execute("""
      CREATE TABLE IF NOT EXISTS contact_fields(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        contact_id INTEGER NOT NULL,
        tipo TEXT NOT NULL,
        valor TEXT,
        FOREIGN KEY (contact_id) REFERENCES contacts(id) ON DELETE CASCADE
      );
    """);
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<int> insertContact(Contact contact) async {
    final db = await database;
    return db.insert("contacts", contact.toMap());
  }

  Future<List<Contact>> getContacts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query("contacts");
    return maps.map((e) => Contact.fromMap(e)).toList();
  }

  Future<Contact?> getContactById(int id) async {
    final db = await database;
    final maps = await db.query("contacts", where: "id=?", whereArgs: [id]);
    if (maps.isEmpty) return null;
    return Contact.fromMap(maps.first);
  }

  Future<int> deleteContact(int id) async {
    final db = await database;
    return db.delete("contacts", where: "id=?", whereArgs: [id]);
  }

  // Campos adicionais
  Future<int> insertContactField(ContactField field) async {
    final db = await database;
    return db.insert("contact_fields", field.toMap());
  }

  Future<List<ContactField>> getFieldsForContact(int contactId) async {
    final db = await database;
    final maps = await db.query("contact_fields", where: "contact_id=?", whereArgs: [contactId]);
    return maps.map((e) => ContactField.fromMap(e)).toList();
  }

  Future<int> deleteContactField(int id) async {
    final db = await database;
    return db.delete("contact_fields", where: "id=?", whereArgs: [id]);
  }
}