import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/cart_item.dart';
import '../data/models/menu_item.dart';
import '../data/repositories/cart_repository.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  final CartRepository _cartRepository;

  CartNotifier(this._cartRepository) : super([]);

  // Charger le panier au démarrage
  Future<void> loadCart() async {
    try {
      final savedCart = await _cartRepository.loadCart();
      state = savedCart;
    } catch (e) {
      // En cas d'erreur, on garde un panier vide
      state = [];
    }
  }

  void addItem(MenuItem menuItem,
      {String? selectedOption, String? specialInstructions}) {
    final existingIndex = state.indexWhere((item) =>
        item.menuItem.id == menuItem.id &&
        item.selectedOption == selectedOption);

    List<CartItem> newState;

    if (existingIndex != -1) {
      // Augmenter la quantité si l'article existe déjà
      final updatedItem = state[existingIndex].copyWith(
        quantity: state[existingIndex].quantity + 1,
      );
      newState = [
        ...state.sublist(0, existingIndex),
        updatedItem,
        ...state.sublist(existingIndex + 1),
      ];
    } else {
      // Ajouter un nouvel article
      final newItem = CartItem(
        id: '${DateTime.now().millisecondsSinceEpoch}',
        menuItem: menuItem,
        quantity: 1,
        selectedOption: selectedOption,
        specialInstructions: specialInstructions,
        addedAt: DateTime.now(),
      );
      newState = [...state, newItem];
    }

    state = newState;
    _saveCart();
  }

  void removeItem(String cartItemId) {
    final newState = state.where((item) => item.id != cartItemId).toList();
    state = newState;
    _saveCart();
  }

  void updateQuantity(String cartItemId, int newQuantity) {
    if (newQuantity <= 0) {
      removeItem(cartItemId);
      return;
    }

    final index = state.indexWhere((item) => item.id == cartItemId);
    if (index != -1) {
      final updatedItem = state[index].copyWith(quantity: newQuantity);
      final newState = [
        ...state.sublist(0, index),
        updatedItem,
        ...state.sublist(index + 1),
      ];
      state = newState;
      _saveCart();
    }
  }

  void clearCart() {
    state = [];
    _cartRepository.clearCart();
  }

  // Sauvegarder le panier
  Future<void> _saveCart() async {
    try {
      await _cartRepository.saveCart(state);
    } catch (e) {
      // On ignore les erreurs de sauvegarde pour ne pas bloquer l'UI
      print('Erreur sauvegarde panier: $e');
    }
  }

  double get totalPrice {
    return state.fold(0, (total, item) => total + item.totalPrice);
  }

  int get totalItems {
    return state.fold(0, (total, item) => total + item.quantity);
  }

  bool get isEmpty => state.isEmpty;
}

// Providers
final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepositoryImpl();
});

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  final repository = ref.watch(cartRepositoryProvider);
  final notifier = CartNotifier(repository);

  // Charger le panier au démarrage
  notifier.loadCart();

  return notifier;
});

final cartTotalProvider = Provider<double>((ref) {
  return ref.watch(cartProvider.notifier).totalPrice;
});

final cartItemsCountProvider = Provider<int>((ref) {
  return ref.watch(cartProvider.notifier).totalItems;
});
