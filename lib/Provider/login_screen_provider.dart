import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../CommonWidgets/common_snack_bar.dart';
import '../Service/api_services.dart';
import '../Service/google_service.dart';

class LoginScreenProvider extends ChangeNotifier {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey();
  bool obscure = true;
  final AuthService _auth = AuthService();
  final ApiService _api = ApiService();
  bool isLoading = false;

  Future<User?> loginWithGoogle() async {
    isLoading = true;
    notifyListeners();
    final user = await _auth.signInWithGoogle();

    isLoading = false;
    notifyListeners();

    return user;
  }

  Future loginUser(BuildContext context) async {

    String loginUrl = '';


    final response = await _api.postMethod(loginUrl, {
      "email": userNameController.text,
      "password": passwordController.text,
    });

    if (response.statusCode == 200) {
      SnackBarHelper.showSnackBar(
        context,
        message: 'Login Successful',

      );
    } else {
      SnackBarHelper.showSnackBar(
        context,
        message:"Invalid Credentials",
        isError: true
      );
    }
  }
}
