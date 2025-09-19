class AuthService {
  static final List<Map<String, String>> _usuarios = [];

  static bool login(String email, String senha) {
    final usuario = _usuarios.firstWhere(
      (u) => u["email"] == email && u["senha"] == senha,
      orElse: () => {},
    );
    return usuario.isNotEmpty;
  }

  static bool registrar(String email, String senha) {
    final existe = _usuarios.any((u) => u["email"] == email);
    if (existe) return false;

    _usuarios.add({"email": email, "senha": senha});
    return true;
  }
}
