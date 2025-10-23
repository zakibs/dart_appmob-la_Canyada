import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/menu_item.dart';
import '../../data/models/cart_item.dart';
import '../../providers/cart_provider.dart';
import '../constants/app_colors.dart';

class QuantitySelector extends ConsumerWidget {
  final MenuItem menuItem;

  const QuantitySelector({
    super.key,
    required this.menuItem,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartItem = cartItems.firstWhere(
      (item) => item.menuItem.id == menuItem.id,
      orElse: () => CartItem(
        id: '',
        menuItem: menuItem,
        quantity: 0,
        addedAt: DateTime.now(),
      ),
    );

    final quantity = cartItem.quantity;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              Icons.remove,
              size: 18,
              color: quantity > 0 ? AppColors.primary : AppColors.textSecondary,
            ),
            onPressed: quantity > 0
                ? () {
                    if (quantity == 1) {
                      ref.read(cartProvider.notifier).removeItem(cartItem.id);
                    } else {
                      ref
                          .read(cartProvider.notifier)
                          .updateQuantity(cartItem.id, quantity - 1);
                    }
                  }
                : null,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
          ),
          Text(
            quantity.toString(),
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              size: 18,
              color: AppColors.primary,
            ),
            onPressed: () {
              if (quantity == 0) {
                ref.read(cartProvider.notifier).addItem(menuItem);
              } else {
                ref
                    .read(cartProvider.notifier)
                    .updateQuantity(cartItem.id, quantity + 1);
              }
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
          ),
        ],
      ),
    );
  }
}
