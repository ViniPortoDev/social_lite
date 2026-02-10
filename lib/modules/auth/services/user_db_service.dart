import 'package:cloud_firestore/cloud_firestore.dart';

class UserDbService {
  UserDbService(this._firestore);

  final FirebaseFirestore _firestore;

  Future<void> saveUserProfile({
    required String uid,
    required String name,
    required String phone,
    required String cpf,
    required String birthDate,
    required String email,
    required DateTime createdAt,
  }) async {
    await _firestore.collection('users').doc(uid).set({
      'uid': uid,
      'name': name,
      'phone': phone,
      'cpf': cpf,
      'birthDate': birthDate,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
    }, SetOptions(merge: true));
  }

  Future<bool> exists(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.exists;
  }
}
