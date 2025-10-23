import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/repositories/auth_repository.dart';
import '../data/models/user.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});

final currentUserProvider = StreamProvider<AppUser?>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return authRepo.authStateChanges.asyncMap((user) async {
    if (user != null) {
      try {
        return await authRepo.getCurrentUser();
      } catch (e) {
        print('Error getting current user: $e');
        return null;
      }
    }
    return null;
  });
});
