// lib/providers/auth_provider.dart
// Provider quản lý trạng thái xác thực toàn cục (đăng nhập/đăng xuất)
// Sử dụng ChangeNotifier để tự động cập nhật UI khi state thay đổi

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Enum trạng thái loading
enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  AuthStatus _status = AuthStatus.initial;
  User? _user;
  String? _errorMessage;

  // ─── Getters ─────────────────────────────────────────────────────────────
  AuthStatus get status => _status;
  User? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == AuthStatus.loading;
  bool get isAuthenticated => _status == AuthStatus.authenticated;

  // ─── Constructor ──────────────────────────────────────────────────────────
  AuthProvider() {
    // Lắng nghe thay đổi trạng thái auth từ Firebase ngay khi khởi tạo
    FirebaseAuth.instance.authStateChanges().listen(_onAuthStateChanged);
  }

  // ─── Xử lý thay đổi trạng thái auth ──────────────────────────────────────
  void _onAuthStateChanged(User? user) {
    _user = user;
    _status =
        user != null ? AuthStatus.authenticated : AuthStatus.unauthenticated;
    notifyListeners();
  }

  // ─── Google Sign-In (Giả lập để vào thẳng Home) ──────────────────────────
  Future<bool> signInWithGoogle() async {
    _setLoading();
    try {
      // Tạo độ trễ nửa giây cho mượt hiệu ứng loading nếu có
      await Future.delayed(const Duration(milliseconds: 500));
      
      _status = AuthStatus.authenticated;
      notifyListeners();
      return true; // Trả về true để màn hình Login biết và tự động chuyển trang
    } catch (e) {
      _setError(e.toString().replaceFirst('Exception: ', ''));
      return false;
    }
  }

  // ─── Email Sign-In (Giả lập thành công trực tiếp) ─────────────────────────
  Future<bool> signInWithEmail(String email, String password) async {
    _setLoading();
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      
      _status = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString().replaceFirst('Exception: ', ''));
      return false;
    }
  }

  // ─── Sign Out (Giả lập đăng xuất sạch sẽ) ─────────────────────────────────
  Future<void> signOut() async {
    _setLoading();
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      
      _user = null;
      _status = AuthStatus.unauthenticated;
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    }
  }

  // ─── Helper methods ───────────────────────────────────────────────────────
  void _setLoading() {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();
  }

  void _setError(String message) {
    _status = AuthStatus.error;
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    if (_user != null) {
      _status = AuthStatus.authenticated;
    } else {
      _status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }
}