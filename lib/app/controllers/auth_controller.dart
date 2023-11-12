import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  String? userid;
  late FirebaseAuth auth;

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      return {
        'error': false,
        'message': 'Login success',
      };
    } on FirebaseAuthException catch (e) {
      return {
        'error': true,
        'message': e.code,
      };
    } catch (e) {
      return {
        'error': true,
        'message': 'Login failed',
      };
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      await auth.signOut();
      return {
        'error': false,
        'message': 'Logout success',
      };
    } on FirebaseAuthException catch (e) {
      return {
        'error': true,
        'message': e.code,
      };
    } catch (e) {
      return {
        'error': true,
        'message': 'Logout failed',
      };
    }
  }

  @override
  void onInit() {
    auth = FirebaseAuth.instance;

    auth.authStateChanges().listen((event) {
      userid = event?.uid;
    });

    super.onInit();
  }
}
