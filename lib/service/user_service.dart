
import 'package:firebase_auth/firebase_auth.dart';

class UserService {

  static final UserService instance = UserService._init();
  UserService._init();
  final _auth = FirebaseAuth.instance;

  Future<String> loadCurrentUser() async {
    String currentUser = "Guest";
    final userCredential = await _auth.currentUser!;
    currentUser = (userCredential.displayName ?? userCredential.phoneNumber ?? userCredential.email!.split("@")[0]);
    return currentUser;
  }

}