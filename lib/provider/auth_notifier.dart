import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modul_6/services/auth/auth_services.dart';

class AuthNotifier with ChangeNotifier {
  final AuthServices _authServices = AuthServices();
  bool _isLoading = false;

  // Diperbaiki: Mengembalikan _isLoading (dengan underscore), bukan memanggil diri sendiri
  bool get isLoading => _isLoading;

  void _setLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> signUp(String email, String password) async{
    _setLoading(true);
    User? user = await _authServices.signUp(email, password);
    _setLoading(false);
    return user != null;
  }

  Future<bool> signIn(String email, String password) async{
    _setLoading(true);
    User? user = await _authServices.signIn(email, password);
    _setLoading(false);
    return user != null;
  }

  Future<void> signOut() async{
    await _authServices.signOut();
  }
}