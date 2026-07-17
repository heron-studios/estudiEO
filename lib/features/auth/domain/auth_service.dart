import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  FirebaseAuth get _auth => FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: kIsWeb
        ? '921397124091-kr9b9smn52r45643qte4am6269gv07l9.apps.googleusercontent.com'
        : (defaultTargetPlatform == TargetPlatform.iOS
              ? '921397124091-k4jfbijukgjspsm0l4k089dcjtuqjenl.apps.googleusercontent.com'
              : null),
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

  bool _isPremium = false;
  bool get isPremium => _isPremium;

  bool _psico = false;
  bool get psico => _psico;

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
      // Wait for at least 3 seconds so the splash screen is visible (only on mobile)
      if (!kIsWeb) {
        await Future.delayed(const Duration(seconds: 3));
      }

      // Esperar a que Firebase termine de cargar la sesión persistida (hasta 2 segundos)
      final user = await _auth.userChanges().first.timeout(
        const Duration(seconds: 2),
        onTimeout: () => _auth.currentUser,
      );

      if (user != null) {
        // Safe timeout for verification in slow networks
        _isAuthorized = await _verifyAuthorization().timeout(
          const Duration(seconds: 10),
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
    _psico = false;
    await _googleSignIn.signOut();
    await _auth.signOut();
    notifyListeners();
  }

  String? _lastVerificationError;
  String? get lastVerificationError => _lastVerificationError;

  Future<bool> _verifyAuthorization() async {
    _lastVerificationError = null;
    final user = _auth.currentUser;
    if (user == null || user.email == null) {
      _lastVerificationError = 'No hay usuario autenticado de Firebase.';
      _isPremium = false;
      return false;
    }

    final email = user.email!.trim();
    final emailLower = email.toLowerCase();
    final emailUpper = email.toUpperCase();
    final emails = {email, emailLower, emailUpper}.toList();
    final errorMsgs = <String>[];

    try {
      // Realizar las consultas de validación en paralelo
      final futures = [
        // 1. Intentar con el correo exacto como ID del documento
        _firestore
            .collection('authorized_users')
            .doc(email)
            .get()
            .then<DocumentSnapshot<Map<String, dynamic>>?>((doc) => doc)
            .catchError((e) {
              debugPrint('Error fetching email doc: $e');
              errorMsgs.add('Doc(correo exacto) error: $e');
              return null;
            }),
        // 2. Intentar con el correo en minúsculas como ID del documento
        _firestore
            .collection('authorized_users')
            .doc(emailLower)
            .get()
            .then<DocumentSnapshot<Map<String, dynamic>>?>((doc) => doc)
            .catchError((e) {
              debugPrint('Error fetching emailLower doc: $e');
              errorMsgs.add('Doc(correo minúscula) error: $e');
              return null;
            }),
        // 3. Intentar con el correo en mayúsculas como ID del documento (por si acaso)
        _firestore
            .collection('authorized_users')
            .doc(emailUpper)
            .get()
            .then<DocumentSnapshot<Map<String, dynamic>>?>((doc) => doc)
            .catchError((e) {
              debugPrint('Error fetching emailUpper doc: $e');
              errorMsgs.add('Doc(correo mayúscula) error: $e');
              return null;
            }),
        // 4. Intentar con el UID como ID del documento (por si el admin asignó por UID)
        _firestore
            .collection('authorized_users')
            .doc(user.uid)
            .get()
            .then<DocumentSnapshot<Map<String, dynamic>>?>((doc) => doc)
            .catchError((e) {
              debugPrint('Error fetching uid doc: $e');
              errorMsgs.add('Doc(UID de Firebase) error: $e');
              return null;
            }),
        // 5. Consultar donde el campo 'email' coincida
        _firestore
            .collection('authorized_users')
            .where('email', whereIn: emails)
            .get()
            .then<QuerySnapshot<Map<String, dynamic>>?>((qs) => qs)
            .catchError((e) {
              debugPrint('Error querying email field: $e');
              errorMsgs.add('Filtro por campo email error: $e');
              return null;
            }),
      ];

      final results = await Future.wait(futures);

      bool foundPremium = false;

      // Verificar los primeros 4 resultados (documentos individuales)
      for (int i = 0; i < 4; i++) {
        final doc = results[i] as DocumentSnapshot<Map<String, dynamic>>?;
        if (doc != null && doc.exists) {
          final data = doc.data();
          if (data != null && _checkIsPaid(data)) {
            _psico = _checkPsicoAccess(data);
            foundPremium = true;
            break;
          }
        }
      }

      if (!foundPremium) {
        // Verificar el 5to resultado (consulta de documentos por campo)
        final querySnapshot =
            results[5 - 1] as QuerySnapshot<Map<String, dynamic>>?;
        if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
          final data = querySnapshot.docs.first.data();
          if (_checkIsPaid(data)) {
            _psico = _checkPsicoAccess(data);
            foundPremium = true;
          }
        }
      }

      _isPremium = foundPremium;

      if (!foundPremium) {
        if (errorMsgs.isNotEmpty) {
          _lastVerificationError =
              'Errores de conexión/permisos de Firestore:\n- ${errorMsgs.join('\n- ')}';
        } else {
          _lastVerificationError = 'Usuario en modo gratuito.';
        }
      }

      // Permitimos el acceso (isAuthorized = true) independientemente de si es Premium o no
      return true;
    } catch (e) {
      debugPrint('Error checking authorization: $e');
      _lastVerificationError = 'Excepción general al verificar: $e';
      return true; // Aún en caso de error de red con Firestore, si el user está en Firebase, entra como gratuito
    }
  }

  bool _checkIsPaid(Map<String, dynamic> data) {
    // 1. Verificar si existen indicadores negativos explícitos en otros campos comunes
    final status = data['status'];
    if (status != null) {
      final s = status.toString().toLowerCase().trim();
      if (s == 'inactivo' ||
          s == 'suspendido' ||
          s == 'bloqueado' ||
          s == 'inactive' ||
          s == 'blocked' ||
          s == 'false' ||
          s == '0') {
        return false;
      }
    }

    final acceso = data['acceso'];
    if (acceso != null) {
      if (acceso is bool && !acceso) return false;
      final s = acceso.toString().toLowerCase().trim();
      if (s == 'false' ||
          s == '0' ||
          s == 'no' ||
          s == 'inactivo' ||
          s == 'bloqueado') {
        return false;
      }
    }

    final isPaid = data['isPaid'];
    // Si el usuario existe en la colección pero no hay campo isPaid ni indicadores negativos,
    // asumimos acceso concedido (el admin lo agregó a la colección para autorizarlo).
    if (isPaid == null) return true;
    if (isPaid is bool) return isPaid;
    if (isPaid is String) {
      final s = isPaid.toLowerCase().trim();
      return s == 'true' ||
          s == 'yes' ||
          s == 'si' ||
          s == 'sí' ||
          s == '1' ||
          s == 'active' ||
          s == 'activo' ||
          s == 'activa' ||
          s == 'habilitado' ||
          s == 'habilitada' ||
          s == 'autorizado' ||
          s == 'autorizada';
    }
    if (isPaid is num) return isPaid == 1;
    return false;
  }

  bool _checkPsicoAccess(Map<String, dynamic> data) {
    final hasAccess = data['psico'];
    if (hasAccess == null) return false;
    if (hasAccess is bool) return hasAccess;
    if (hasAccess is String) {
      final s = hasAccess.toLowerCase().trim();
      return s == 'true' || s == 'yes' || s == 'si' || s == 'sí' || s == '1';
    }
    if (hasAccess is num) return hasAccess == 1;
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
