import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/menu_item_card.dart';
import '../../data/models/category.dart';
import '../../providers/menu_provider.dart';

class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Category category =
        ModalRoute.of(context)!.settings.arguments as Category;
    final menuItems = ref.watch(categoryItemsProvider(category.name));

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: menuItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fastfood,
                    size: 64,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Aucun article disponible',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final menuItem = menuItems[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: MenuItemCard(menuItem: menuItem),
                );
              },
            ),
    );
  }
}
