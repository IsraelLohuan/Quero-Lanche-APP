import 'package:firebase_auth/firebase_auth.dart';

abstract class ILoginRepository {
  Future<UserCredential> login();
  Future<void> logout();
}