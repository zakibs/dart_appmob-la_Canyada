import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String id;
  final String userId;
  final double total;
  final DateTime orderDate;
  final String status;

  Order({
    required this.id,
    required this.userId,
    required this.total,
    required this.orderDate,
    required this.status,
  });

  /// ✅ Create Order from Firestore document
  factory Order.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Order(
      id: doc.id,
      userId: data['userId'] ?? '',
      total: (data['total'] ?? 0).toDouble(),
      orderDate: (data['orderDate'] is Timestamp)
          ? (data['orderDate'] as Timestamp).toDate()
          : DateTime.tryParse(data['orderDate'].toString()) ?? DateTime.now(),
      status: data['status'] ?? 'pending',
    );
  }

  /// ✅ Convert Order to Firestore JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'total': total,
      'orderDate': orderDate,
      'status': status,
    };
  }
}
