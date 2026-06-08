import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hello/models/app_user.dart';

class UserService {
  // initialisation de la basse de donnée fire base
  final database = FirebaseFirestore.instance;

  //  creer un utilisateur
  Future<void> createUser(AppUser user) async {
    await database.collection('users').doc(user.uid).set(user.toJson());
  }

  // recuperer un utilisateur
  Future<AppUser?> getUser(String uid) async {
    final doc = await database.collection("users").doc(uid).get();
    if (doc.exists) {
      return AppUser.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  // recuper tous les utilisateurs
  Stream<List<AppUser>> get getAllUsers {
    final snapshot = database.collection("users").snapshots();
    return snapshot.map((doc) {
      return doc.docs.map((event) {
        return AppUser.fromJson(event.data());
      }).toList();
    });
  }

  // mettre à jour un utilisateur(update)
  Future<void> updateUser(AppUser user) async {
    await database.collection('user').doc(user.uid).update(user.toJson());
  }

  // supprimer un utilisateur
  Future<void> deleteUser(String uid) async {
    await database.collection('user').doc(uid).delete();
  }
}
