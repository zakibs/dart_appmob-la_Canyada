import '../models/menu_item.dart';
import '../models/category.dart';

class MenuRepository {
  // Données mockées basées sur les photos du menu
  List<Category> getCategories() {
    return [
      Category(
        id: '1',
        name: 'Salades',
        imageUrl: 'assets/images/categories/salades.jpg',
        itemCount: 3,
      ),
      Category(
        id: '2',
        name: 'Poulet',
        imageUrl: 'assets/images/categories/poulet.jpg',
        itemCount: 7,
      ),
      Category(
        id: '3',
        name: 'Tacos',
        imageUrl: 'assets/images/categories/tacos.jpg',
        itemCount: 6,
      ),
      Category(
        id: '4',
        name: 'Sandwich et Chawarma',
        imageUrl: 'assets/images/categories/sandwich.jpg',
        itemCount: 4,
      ),
      Category(
        id: '5',
        name: 'Grillade',
        imageUrl: 'assets/images/categories/grillade.jpg',
        itemCount: 4,
      ),
      Category(
        id: '6',
        name: 'Pâtes',
        imageUrl: 'assets/images/categories/pates.jpg',
        itemCount: 7,
      ),
      Category(
        id: '7',
        name: 'Menu Enfant',
        imageUrl: 'assets/images/categories/menu_enfant.jpg',
        itemCount: 1,
      ),
      Category(
        id: '8',
        name: 'Jus',
        imageUrl: 'assets/images/categories/jus.jpg',
        itemCount: 4,
      ),
      Category(
        id: '9',
        name: 'Desserts',
        imageUrl: 'assets/images/categories/desserts.jpg',
        itemCount: 4,
      ),
      Category(
        id: '10',
        name: 'Suppléments',
        imageUrl: 'assets/images/categories/supplements.jpg',
        itemCount: 7,
      ),
      Category(
        id: '11',
        name: 'Boissons',
        imageUrl: 'assets/images/categories/boissons.jpg',
        itemCount: 3,
      ),
      Category(
        id: '12',
        name: 'Couscous',
        imageUrl: 'assets/images/categories/couscous.jpg',
        itemCount: 1,
      ),
    ];
  }

  List<MenuItem> getMenuItems() {
    return [
      // Salades
      MenuItem(
        id: 's1',
        name: 'Salade chef',
        description: 'Salade fraîche du chef',
        price: 25.0,
        category: 'Salades',
        imageUrl: 'assets/images/products/salade_chef.jpg',
      ),
      MenuItem(
        id: 's2',
        name: 'Salade la canyada',
        description: 'Notre salade signature',
        price: 30.0,
        category: 'Salades',
        imageUrl: 'assets/images/products/salade_canyada.jpg',
      ),
      MenuItem(
        id: 's3',
        name: 'Salade mexicaine',
        description: 'Salade épicée à la mexicaine',
        price: 23.0,
        category: 'Salades',
        imageUrl: 'assets/images/products/salade_mexicaine.jpg',
      ),

      // Plats de poulet
      MenuItem(
        id: 'p1',
        name: 'Chicken la canyada à la crème blanche',
        description: 'Poulet à la crème blanche',
        price: 35.0,
        category: 'Poulet',
        imageUrl: 'assets/images/products/chicken_creme_blanche.jpg',
      ),
      MenuItem(
        id: 'p2',
        name: 'Chicken la canyada à la crème champignons',
        description: 'Poulet à la crème et champignons',
        price: 40.0,
        category: 'Poulet',
        imageUrl: 'assets/images/products/chicken_creme_champignons.jpg',
      ),
      MenuItem(
        id: 'p3',
        name: 'Chicken la canyada avec légumes',
        description: 'Poulet aux légumes frais',
        price: 40.0,
        category: 'Poulet',
        imageUrl: 'assets/images/products/chicken_legumes.jpg',
      ),
      MenuItem(
        id: 'p4',
        name: 'Chicken américain',
        description: 'Poulet style américain',
        price: 35.0,
        category: 'Poulet',
        imageUrl: 'assets/images/products/chicken_americain.jpg',
      ),
      MenuItem(
        id: 'p5',
        name: 'Chicken mixte',
        description: 'Assortiment de poulet',
        price: 45.0,
        category: 'Poulet',
        imageUrl: 'assets/images/products/chicken_mixte.jpg',
      ),
      MenuItem(
        id: 'p6',
        name: 'Émincé de poulet moutarde à l\'ancienne',
        description: 'Émincé de poulet à la moutarde',
        price: 40.0,
        category: 'Poulet',
        imageUrl: 'assets/images/products/emince_moutarde.jpg',
      ),
      MenuItem(
        id: 'p7',
        name: 'Émincé de poulet à la crème champignons',
        description: 'Émincé de poulet crème champignons',
        price: 40.0,
        category: 'Poulet',
        imageUrl: 'assets/images/products/emince_creme_champignons.jpg',
      ),

      // Tacos
      MenuItem(
        id: 't1',
        name: 'Tacos viande hachée',
        description: 'Tacos à la viande hachée',
        price: 28.0,
        category: 'Tacos',
        imageUrl: 'assets/images/products/tacos_viande.jpg',
        options: ['Seul', 'Menu'],
      ),
      MenuItem(
        id: 't2',
        name: 'Tacos poulet',
        description: 'Tacos au poulet',
        price: 25.0,
        category: 'Tacos',
        imageUrl: 'assets/images/products/tacos_poulet.jpg',
        options: ['Seul', 'Menu'],
      ),
      MenuItem(
        id: 't3',
        name: 'Tacos chawarma',
        description: 'Tacos chawarma',
        price: 30.0,
        category: 'Tacos',
        imageUrl: 'assets/images/products/tacos_chawarma.jpg',
        options: ['Seul', 'Menu'],
      ),
      MenuItem(
        id: 't4',
        name: 'Tacos merguez',
        description: 'Tacos à la merguez',
        price: 28.0,
        category: 'Tacos',
        imageUrl: 'assets/images/products/tacos_merguez.jpg',
        options: ['Seul', 'Menu'],
      ),
      MenuItem(
        id: 't5',
        name: 'Tacos mixte',
        description: 'Tacos mixte',
        price: 33.0,
        category: 'Tacos',
        imageUrl: 'assets/images/products/tacos_mixte.jpg',
        options: ['Seul', 'Menu'],
      ),
      MenuItem(
        id: 't6',
        name: 'Tacos la canyada',
        description: 'Notre tacos signature',
        price: 30.0,
        category: 'Tacos',
        imageUrl: 'assets/images/products/tacos_canyada.jpg',
        options: ['Seul', 'Menu'],
      ),

      // Sandwich et Chawarma
      MenuItem(
        id: 'sc1',
        name: 'Chawarma super',
        description: 'Chawarma super',
        price: 32.0,
        category: 'Sandwich et Chawarma',
        imageUrl: 'assets/images/products/chawarma_super.jpg',
      ),
      MenuItem(
        id: 'sc2',
        name: 'Chawarma 3 fromages',
        description: 'Chawarma aux 3 fromages',
        price: 28.0,
        category: 'Sandwich et Chawarma',
        imageUrl: 'assets/images/products/chawarma_3fromages.jpg',
      ),
      MenuItem(
        id: 'sc3',
        name: 'Chawarma la canyada',
        description: 'Notre chawarma signature',
        price: 25.0,
        category: 'Sandwich et Chawarma',
        imageUrl: 'assets/images/products/chawarma_canyada.jpg',
      ),
      MenuItem(
        id: 'sc4',
        name: 'Chawarma plat',
        description: 'Chawarma en plat',
        price: 35.0,
        category: 'Sandwich et Chawarma',
        imageUrl: 'assets/images/products/chawarma_plat.jpg',
      ),

      // Pâtes
      MenuItem(
        id: 'pa1',
        name: 'Spaghetti bolognaise',
        description: 'Spaghetti à la bolognaise',
        price: 30.0,
        category: 'Pâtes',
        imageUrl: 'assets/images/products/spaghetti_bolognaise.jpg',
      ),
      MenuItem(
        id: 'pa2',
        name: 'Penné au thon',
        description: 'Penné au thon',
        price: 30.0,
        category: 'Pâtes',
        imageUrl: 'assets/images/products/penne_thon.jpg',
      ),
      MenuItem(
        id: 'pa3',
        name: 'Penné venestenne',
        description: 'Penné venestenne',
        price: 35.0,
        category: 'Pâtes',
        imageUrl: 'assets/images/products/penne_venestenne.jpg',
      ),
      MenuItem(
        id: 'pa4',
        name: 'Pâtes au 4 fromages',
        description: 'Pâtes aux 4 fromages',
        price: 40.0,
        category: 'Pâtes',
        imageUrl: 'assets/images/products/pates_4fromages.jpg',
      ),
      MenuItem(
        id: 'pa5',
        name: 'Penné poulet champignons',
        description: 'Penné au poulet et champignons',
        price: 35.0,
        category: 'Pâtes',
        imageUrl: 'assets/images/products/penne_poulet_champignons.jpg',
      ),
      MenuItem(
        id: 'pa6',
        name: 'Tagliatelle carbonara',
        description: 'Tagliatelle carbonara',
        price: 35.0,
        category: 'Pâtes',
        imageUrl: 'assets/images/products/tagliatelle_carbonara.jpg',
      ),
      MenuItem(
        id: 'pa7',
        name: 'Tagliatelle fruits de mer',
        description: 'Tagliatelle aux fruits de mer',
        price: 40.0,
        category: 'Pâtes',
        imageUrl: 'assets/images/products/tagliatelle_fruits_mer.jpg',
      ),

      // Menu Enfant
      MenuItem(
        id: 'me1',
        name: 'Menu burger + frites + soda',
        description: 'Menu complet pour enfant',
        price: 25.0,
        category: 'Menu Enfant',
        imageUrl: 'assets/images/products/menu_enfant.jpg',
      ),

      // Jus
      MenuItem(
        id: 'j1',
        name: 'Jus d\'orange',
        description: 'Jus d\'orange frais',
        price: 15.0,
        category: 'Jus',
        imageUrl: 'assets/images/products/jus_orange.jpg',
      ),
      MenuItem(
        id: 'j2',
        name: 'Jus de citron',
        description: 'Jus de citron frais',
        price: 7.0,
        category: 'Jus',
        imageUrl: 'assets/images/products/jus_citron.jpg',
      ),
      MenuItem(
        id: 'j3',
        name: 'Jus carotte orange',
        description: 'Mélange carotte et orange',
        price: 7.0,
        category: 'Jus',
        imageUrl: 'assets/images/products/jus_carotte_orange.jpg',
      ),
      MenuItem(
        id: 'j4',
        name: 'Jus betterave',
        description: 'Jus de betterave frais',
        price: 7.0,
        category: 'Jus',
        imageUrl: 'assets/images/products/jus_betterave.jpg',
      ),

      // Desserts
      MenuItem(
        id: 'd1',
        name: 'Mousse au chocolat',
        description: 'Mousse au chocolat maison',
        price: 15.0,
        category: 'Desserts',
        imageUrl: 'assets/images/products/mousse_chocolat.jpg',
      ),
      MenuItem(
        id: 'd2',
        name: 'Panna cotta',
        description: 'Panna cotta crémeuse',
        price: 15.0,
        category: 'Desserts',
        imageUrl: 'assets/images/products/panna_cotta.jpg',
      ),
      MenuItem(
        id: 'd3',
        name: 'Salade de fruits',
        description: 'Salade de fruits frais',
        price: 15.0,
        category: 'Desserts',
        imageUrl: 'assets/images/products/salade_fruits.jpg',
      ),
      MenuItem(
        id: 'd4',
        name: 'Mhalabia',
        description: 'Dessert traditionnel',
        price: 10.0,
        category: 'Desserts',
        imageUrl: 'assets/images/products/mhalabia.jpg',
      ),

      // Couscous
      MenuItem(
        id: 'c1',
        name: 'Couscous viande',
        description:
            'Couscous traditionnel à la viande - Disponible le vendredi',
        price: 35.0,
        category: 'Couscous',
        imageUrl: 'assets/images/products/couscous_viande.jpg',
      ),
    ];
  }

  List<MenuItem> getItemsByCategory(String category) {
    return getMenuItems().where((item) => item.category == category).toList();
  }

  MenuItem? getItemById(String id) {
    try {
      return getMenuItems().firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }
}
