import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String id;
  final String email;
  final String? name;
  final DateTime createdAt;

  AppUser({
    required this.id,
    required this.email,
    this.name,
    required this.createdAt,
  });

  /// Create a user from Firestore document
  factory AppUser.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return AppUser(
      id: doc.id,
      email: data['email'] ?? '',
      name: data['name'],
      createdAt: (data['createdAt'] is Timestamp)
          ? (data['createdAt'] as Timestamp).toDate()
          : DateTime.tryParse(data['createdAt'].toString()) ?? DateTime.now(),
    );
  }

  /// Convert user to Firestore JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'createdAt': createdAt,
    };
  }
}
