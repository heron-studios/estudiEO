import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:learn/core/config/app_config.dart';

class AuthService extends ChangeNotifier {
  FirebaseAuth get _auth => FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: kIsWeb
        ? '921397124091-kr9b9smn52r45643qte4am6269gv07l9.apps.googleusercontent.com'
        : null,
  );
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  User? get currentUser {
    try {
      return _auth.currentUser;
    } catch (_) {
      return null;
    }
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isInitializing = true;
  bool get isInitializing => _isInitializing;

  bool _isAuthorized = false;
  bool get isAuthorized => _isAuthorized;

  String? _error;
  String? get error => _error;

  bool _initStarted = false;

  AuthService() {
    _isInitializing = true;
    if (!_initStarted) {
      _initStarted = true;
      // Check auth in background, don't wait
      Future.microtask(_checkInitialAuth);
    }
  }

  Future<void> _checkInitialAuth() async {
    try {
      // In web with demo mode, skip checks entirely
      if (AppConfig.isDemoMode) {
        _isAuthorized = true;
        return;
      }

      if (currentUser != null) {
        // Short timeout for verification
        _isAuthorized = await _verifyAuthorization().timeout(
          const Duration(seconds: 3),
          onTimeout: () {
            debugPrint('Auth check timeout');
            return false;
          },
        );
      } else {
        _isAuthorized = false;
      }
    } catch (e) {
      debugPrint('Auth check error: $e');
      _isAuthorized = false;
    } finally {
      _isInitializing = false;
      notifyListeners();
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _error = message;
    notifyListeners();
  }

  void setAuthorized(bool value) {
    _isAuthorized = value;
    notifyListeners();
  }

  /// Inicia sesión con Google
  Future<UserCredential?> signInWithGoogle() async {
    _setLoading(true);
    _setError(null);

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        _setLoading(false);
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      // We do NOT call setLoading(false) here or notifyListeners right away.
      // The caller (LoginScreen) will verify authorization and set it.
      return userCredential;
    } on FirebaseAuthException catch (e) {
      _setError(e.message ?? 'Error desconocido de autenticación');
      _setLoading(false);
      return null;
    } catch (e) {
      _setError('Error al iniciar sesión: $e');
      _setLoading(false);
      return null;
    }
  }

  /// Cierra sesión
  Future<void> signOut() async {
    _isAuthorized = false;
    await _googleSignIn.signOut();
    await _auth.signOut();
    notifyListeners();
  }

  /// Verifica si el usuario actual tiene permisos en Firestore
  Future<bool> _verifyAuthorization() async {
    if (AppConfig.isDemoMode) return true; // Bypass check in demo mode
    final user = _auth.currentUser;
    if (user == null || user.email == null) return false;

    final email = user.email!.trim();
    final emailLower = email.toLowerCase();

    try {
      // 1. Try exact email as document ID
      var doc = await _firestore
          .collection('authorized_users')
          .doc(email)
          .get();
      if (doc.exists) {
        final data = doc.data();
        if (data != null && _checkIsPaid(data)) return true;
      }

      // 2. Try lowercase email as document ID
      doc = await _firestore
          .collection('authorized_users')
          .doc(emailLower)
          .get();
      if (doc.exists) {
        final data = doc.data();
        if (data != null && _checkIsPaid(data)) return true;
      }

      // 3. Try query by 'email' field (exact match)
      var query = await _firestore
          .collection('authorized_users')
          .where('email', isEqualTo: email)
          .get();
      if (query.docs.isNotEmpty) {
        final data = query.docs.first.data();
        if (_checkIsPaid(data)) return true;
      }

      // 4. Try query by 'email' field (lowercase match)
      query = await _firestore
          .collection('authorized_users')
          .where('email', isEqualTo: emailLower)
          .get();
      if (query.docs.isNotEmpty) {
        final data = query.docs.first.data();
        if (_checkIsPaid(data)) return true;
      }

      return false;
    } catch (e) {
      debugPrint('Error checking authorization: $e');
      return false;
    }
  }

  bool _checkIsPaid(Map<String, dynamic> data) {
    final isPaid = data['isPaid'];
    if (isPaid == null) return false;
    if (isPaid is bool) return isPaid;
    if (isPaid is String) {
      final s = isPaid.toLowerCase().trim();
      return s == 'true' || s == 'yes' || s == 'si' || s == 'sí' || s == '1';
    }
    if (isPaid is num) return isPaid == 1;
    return false;
  }

  // Exposed for LoginScreen to call
  Future<bool> checkAndSetAuthorization() async {
    final authorized = await _verifyAuthorization();
    _isAuthorized = authorized;
    _setLoading(false); // finish the sign-in loading state
    return authorized;
  }
}
