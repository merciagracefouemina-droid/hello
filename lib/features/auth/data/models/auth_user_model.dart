import 'package:hello/features/auth/domain/entites/auth_user.dart';

class AuthUserModel extends AuthUser {
  // creation du modèle Authuser qui etend l'entité aut
  AuthUserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.imageUrl,
  });

  // methode pour convertir une instance de AuthUserModel en Json
  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'name': name, 'imageUrl': imageUrl};
  }

  // factory methode pour creer une instance de AuthUserModel à partir d'un Json
  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
