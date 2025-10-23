import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/menu_repository.dart';
import '../data/models/menu_item.dart';
import '../data/models/category.dart';

final menuRepositoryProvider = Provider<MenuRepository>((ref) {
  return MenuRepository();
});

final categoriesProvider = Provider<List<Category>>((ref) {
  final repository = ref.watch(menuRepositoryProvider);
  return repository.getCategories();
});

final menuItemsProvider = Provider<List<MenuItem>>((ref) {
  final repository = ref.watch(menuRepositoryProvider);
  return repository.getMenuItems();
});

final categoryItemsProvider = Provider.family<List<MenuItem>, String>((
  ref,
  category,
) {
  final repository = ref.watch(menuRepositoryProvider);
  return repository.getItemsByCategory(category);
});
