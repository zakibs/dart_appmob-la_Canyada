import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item.dart';

abstract class CartRepository {
  Future<void> saveCart(List<CartItem> cartItems);
  Future<List<CartItem>> loadCart();
  Future<void> clearCart();
}

class CartRepositoryImpl implements CartRepository {
  static const String _cartKey = 'cart_items';

  @override
  Future<void> saveCart(List<CartItem> cartItems) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJsonList = cartItems.map((item) => item.toJson()).toList();
      await prefs.setString(_cartKey, json.encode(cartJsonList));
    } catch (e) {
      throw Exception('Erreur lors de la sauvegarde du panier: $e');
    }
  }

  @override
  Future<List<CartItem>> loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = prefs.getString(_cartKey);

      if (cartJson == null) {
        return [];
      }

      final cartList = json.decode(cartJson) as List;
      return cartList.map((itemJson) => CartItem.fromJson(itemJson)).toList();
    } catch (e) {
      throw Exception('Erreur lors du chargement du panier: $e');
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cartKey);
    } catch (e) {
      throw Exception('Erreur lors de la suppression du panier: $e');
    }
  }
}
