import '../models/contact_model.dart';
import '../models/contact_field_model.dart';
import '../services/contact_dbhelper.dart';

class ContactController {
  final _dbHelper = ContactDBHelper();

  // CRUD Contato
  Future<int> createContact(Contact contact) async {
    return _dbHelper.insertContact(contact);
  }

  Future<List<Contact>> readContacts() async {
    return _dbHelper.getContacts();
  }

  Future<Contact?> readContactById(int id) async {
    return _dbHelper.getContactById(id);
  }

  Future<int> deleteContact(int id) async {
    return _dbHelper.deleteContact(id);
  }

  // CRUD Campos Adicionais
  Future<int> addContactField(ContactField field) async {
    return _dbHelper.insertContactField(field);
  }

  Future<List<ContactField>> readFieldsForContact(int contactId) async {
    return _dbHelper.getFieldsForContact(contactId);
  }

  Future<int> deleteContactField(int id) async {
    return _dbHelper.deleteContactField(id);
  }
}