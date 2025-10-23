import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../data/services/location_service.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';
import '../../providers/auth_provider.dart';

class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({super.key});

  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  final _addressController = TextEditingController();
  final _instructionsController = TextEditingController();
  LatLng? _selectedLocation;
  bool _isLoading = false;

  @override
  void dispose() {
    _addressController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);
    try {
      final position = await LocationService.getCurrentLocation();
      final address = await LocationService.getAddressFromLatLng(
        position.latitude,
        position.longitude,
      );

      if (!mounted) return;
      setState(() {
        _selectedLocation = LatLng(position.latitude, position.longitude);
        _addressController.text = address;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur de localisation: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _placeOrder() async {
    if (_addressController.text.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez entrer une adresse de livraison'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final cartItems = ref.read(cartProvider);
      final total = ref.read(cartTotalProvider);
      final user = ref.read(currentUserProvider).value;

      if (user == null) throw Exception('Utilisateur non connecté');

      // Calculer les frais de livraison
      const deliveryFee = 20.0; // Frais fixes pour l'exemple

      final orderData = {
        'id': '',
        'userId': user.id,
        'items': cartItems,
        'total': total,
        'deliveryFee': deliveryFee,
        'orderDate': DateTime.now().toIso8601String(),
        'status': 'pending',
        'deliveryAddress': _addressController.text,
        'deliveryLocation': _selectedLocation != null
            ? {
                'latitude': _selectedLocation!.latitude,
                'longitude': _selectedLocation!.longitude
              }
            : null,
        'paymentMethod': 'cash',
        'specialInstructions': _instructionsController.text,
      };

      // Use dynamic to avoid compile-time mismatch with repository typing in this file.
      final dynamic orderRepo = ref.read(orderRepositoryProvider);
      final orderId = await orderRepo.createOrder(orderData);

      // Vider le panier
      ref.read(cartProvider.notifier).clearCart();

      // Naviguer vers le suivi de commande
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => _buildOrderTrackingPlaceholder(orderId),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la commande: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // Minimal order tracking page to satisfy navigation target and avoid undefined symbol.
  // This keeps the same concept: navigate to a tracking screen with the order id.
  // You can replace this with your real OrderTrackingPage implementation.
  Widget _buildOrderTrackingPlaceholder(String orderId) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suivi de la commande'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 80,
              color: AppColors.success,
            ),
            const SizedBox(height: 20),
            Text(
              'Commande créée avec succès!',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'ID: $orderId',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: const Text('Retour à l\'accueil'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    final total = ref.watch(cartTotalProvider);
    const deliveryFee = 20.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Finaliser la commande'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Adresse de livraison',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _addressController,
                                decoration: const InputDecoration(
                                  labelText: 'Adresse complète',
                                  border: OutlineInputBorder(),
                                ),
                                maxLines: 2,
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              onPressed: _getCurrentLocation,
                              icon: const Icon(Icons.my_location),
                              tooltip: 'Utiliser ma position actuelle',
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _instructionsController,
                          decoration: const InputDecoration(
                            labelText: 'Instructions spéciales (optionnel)',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Méthode de paiement',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.money,
                                color: AppColors.success),
                            title: const Text('Paiement à la livraison'),
                            subtitle: const Text('Espèces uniquement'),
                            trailing: Radio<String>(
                              value: 'cash',
                              groupValue: 'cash',
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Récapitulatif',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...cartItems.map((item) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                backgroundColor: AppColors.background,
                                child: Text(item.quantity.toString()),
                              ),
                              title: Text(item.menuItem.name),
                              trailing: Text(
                                '${item.totalPrice.toStringAsFixed(0)} DH',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )),
                        const Divider(),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Sous-total'),
                          trailing: Text('${total.toStringAsFixed(0)} DH'),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Frais de livraison'),
                          trailing:
                              Text('${deliveryFee.toStringAsFixed(0)} DH'),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            'Total',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          trailing: Text(
                            '${(total + deliveryFee).toStringAsFixed(0)} DH',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, -2),
                        blurRadius: 8,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _placeOrder,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Confirmer la commande - ${(total + deliveryFee).toStringAsFixed(0)} DH',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
