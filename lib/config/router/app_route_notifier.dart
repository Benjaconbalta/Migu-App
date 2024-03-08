import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = Provider((ref) => FirebaseAuth.instance);
final goRouterNotifierProvider = Provider((ref) {
  final auth = ref.read(authProvider);
  final goRouterNotifier = GoRouterNotifier();

  auth.authStateChanges().listen((user) {
    if (user != null) {
      goRouterNotifier.setAuthStatus(true);
    } else {
      goRouterNotifier.setAuthStatus(false);
    }
  });

  return goRouterNotifier;
});

class GoRouterNotifier extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void setAuthStatus(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }
}