import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRepository({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  /// Stream to listen to auth state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Get the currently signed-in user and load from Firestore
  Future<AppUser> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('Utilisateur non connecté');
    }

    final doc = await _firestore.collection('users').doc(user.uid).get();

    if (doc.exists && doc.data() != null) {
      return AppUser.fromFirestore(doc);
    } else {
      // Create a new user if none exists
      final newUser = AppUser(
        id: user.uid,
        email: user.email ?? '',
        createdAt: DateTime.now(),
      );
      await _firestore.collection('users').doc(user.uid).set(newUser.toJson());
      return newUser;
    }
  }

  /// Sign in with email and password
  Future<AppUser> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await getCurrentUser();
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  /// Sign up with email, password, and name
  Future<AppUser> signUpWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = AppUser(
        id: credential.user!.uid,
        email: email,
        name: name,
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .set(user.toJson());

      return user;
    } catch (e) {
      throw Exception('Erreur d\'inscription: $e');
    }
  }

  /// Sign out user
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// Update user profile data in Firestore
  Future<void> updateUserProfile(AppUser user) async {
    await _firestore.collection('users').doc(user.id).update(user.toJson());
  }
}
