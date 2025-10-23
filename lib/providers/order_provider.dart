import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/order_repository.dart';
import '../data/models/order.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository();
});

final userOrdersProvider =
    StreamProvider.autoDispose.family<List<Order>, String>((ref, userId) {
  final repository = ref.watch(orderRepositoryProvider);
  return repository.getUserOrders(userId);
});

final orderProvider =
    StreamProvider.autoDispose.family<Order?, String>((ref, orderId) {
  final repository = ref.watch(orderRepositoryProvider);
  return repository.getOrderById(orderId);
});
