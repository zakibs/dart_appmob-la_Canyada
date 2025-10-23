import 'package:flutter/foundation.dart';
import 'menu_item.dart';

@immutable
class CartItem {
  final String id;
  final MenuItem menuItem;
  final int quantity;
  final String? selectedOption;
  final String? specialInstructions;
  final DateTime addedAt;

  const CartItem({
    required this.id,
    required this.menuItem,
    required this.quantity,
    this.selectedOption,
    this.specialInstructions,
    required this.addedAt,
  });

  double get totalPrice => menuItem.price * quantity;

  CartItem copyWith({
    String? id,
    MenuItem? menuItem,
    int? quantity,
    String? selectedOption,
    String? specialInstructions,
    DateTime? addedAt,
  }) {
    return CartItem(
      id: id ?? this.id,
      menuItem: menuItem ?? this.menuItem,
      quantity: quantity ?? this.quantity,
      selectedOption: selectedOption ?? this.selectedOption,
      specialInstructions: specialInstructions ?? this.specialInstructions,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'menuItem': menuItem.toJson(),
      'quantity': quantity,
      'selectedOption': selectedOption,
      'specialInstructions': specialInstructions,
      'addedAt': addedAt.toIso8601String(),
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      menuItem: MenuItem.fromJson(json['menuItem']),
      quantity: json['quantity'],
      selectedOption: json['selectedOption'],
      specialInstructions: json['specialInstructions'],
      addedAt: DateTime.parse(json['addedAt']),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem &&
        other.id == id &&
        other.menuItem == menuItem &&
        other.quantity == quantity &&
        other.selectedOption == selectedOption &&
        other.specialInstructions == specialInstructions;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      menuItem,
      quantity,
      selectedOption,
      specialInstructions,
    );
  }

  @override
  String toString() {
    return 'CartItem(id: $id, menuItem: $menuItem, quantity: $quantity, selectedOption: $selectedOption, specialInstructions: $specialInstructions, addedAt: $addedAt)';
  }
}
