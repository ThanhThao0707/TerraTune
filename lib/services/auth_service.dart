// lib/services/auth_service.dart
// Service xử lý toàn bộ logic xác thực: Google Sign-In, Email/Password, Sign Out
// Tách biệt hoàn toàn khỏi UI để dễ test và bảo trì

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Singleton instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // ─── Stream trạng thái người dùng ────────────────────────────────────────
  // Lắng nghe thay đổi trạng thái đăng nhập theo thời gian thực
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Lấy user hiện tại (null nếu chưa đăng nhập)
  User? get currentUser => _auth.currentUser;

  // ─── Google Sign-In ───────────────────────────────────────────────────────
  /// Đăng nhập bằng Google Account
  /// Trả về [User] nếu thành công, ném [Exception] nếu thất bại
  Future<User?> signInWithGoogle() async {
    try {
      // Mở popup chọn tài khoản Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Người dùng đóng popup
      if (googleUser == null) return null;

      // Lấy token xác thực từ Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Tạo credential cho Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Đăng nhập vào Firebase bằng Google credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseError(e);
    } catch (e) {
      throw Exception('Đăng nhập Google thất bại: ${e.toString()}');
    }
  }

  // ─── Email & Password Sign-In ─────────────────────────────────────────────
  /// Đăng nhập bằng Email + Mật khẩu
  Future<User?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseError(e);
    }
  }

  /// Đăng ký tài khoản mới bằng Email + Mật khẩu
  Future<User?> registerWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseError(e);
    }
  }

  // ─── Sign Out ─────────────────────────────────────────────────────────────
  /// Đăng xuất khỏi cả Firebase và Google
  Future<void> signOut() async {
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  // ─── Error Handler ────────────────────────────────────────────────────────
  /// Chuyển đổi FirebaseAuthException thành thông báo tiếng Việt thân thiện
  Exception _handleFirebaseError(FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case 'user-not-found':
        message = 'Không tìm thấy tài khoản với email này.';
        break;
      case 'wrong-password':
        message = 'Mật khẩu không đúng.';
        break;
      case 'invalid-email':
        message = 'Địa chỉ email không hợp lệ.';
        break;
      case 'email-already-in-use':
        message = 'Email này đã được sử dụng.';
        break;
      case 'weak-password':
        message = 'Mật khẩu quá yếu (tối thiểu 6 ký tự).';
        break;
      case 'network-request-failed':
        message = 'Lỗi kết nối mạng. Vui lòng thử lại.';
        break;
      case 'too-many-requests':
        message = 'Quá nhiều lần thử. Vui lòng thử lại sau.';
        break;
      default:
        message = 'Lỗi xác thực: ${e.message}';
    }
    return Exception(message);
  }
}
