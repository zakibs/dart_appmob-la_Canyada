import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import '../models/order.dart';

class OrderRepository {
  final FirebaseFirestore _firestore;

  OrderRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// ✅ Create a new order in Firestore
  Future<String> createOrder(Order order) async {
    final docRef = await _firestore.collection('orders').add(order.toJson());
    return docRef.id;
  }

  /// ✅ Get all orders of a specific user (sorted by orderDate)
  Stream<List<Order>> getUserOrders(String userId) {
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('orderDate', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Order.fromFirestore(doc)).toList());
  }

  /// ✅ Get one order by ID (live updates)
  Stream<Order?> getOrderById(String orderId) {
    return _firestore.collection('orders').doc(orderId).snapshots().map(
        (snapshot) => snapshot.exists ? Order.fromFirestore(snapshot) : null);
  }

  /// ✅ Update order (optional convenience)
  Future<void> updateOrder(Order order) async {
    await _firestore.collection('orders').doc(order.id).update(order.toJson());
  }

  /// ✅ Delete an order
  Future<void> deleteOrder(String orderId) async {
    await _firestore.collection('orders').doc(orderId).delete();
  }
}
