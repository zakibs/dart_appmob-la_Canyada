import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/constants/app_colors.dart';
import '../../data/models/order.dart';
import '../../providers/order_provider.dart';

class OrderTrackingPage extends ConsumerWidget {
  final String orderId;

  const OrderTrackingPage({super.key, required this.orderId});

  Future<void> _callDriver(BuildContext context) async {
    const phoneNumber = '0522709807';
    final url = Uri.parse('tel:$phoneNumber');
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Impossible d\'appeler le livreur')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderAsync = ref.watch(orderProvider(orderId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Suivi de commande'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: orderAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 50, color: AppColors.error),
              const SizedBox(height: 16),
              Text(
                'Erreur de chargement',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        data: (order) {
          if (order == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off,
                      size: 50, color: AppColors.textSecondary),
                  const SizedBox(height: 16),
                  Text(
                    'Commande non trouvée',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order Status Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Commande #${order.id.substring(0, 8)}',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(
                              _getStatusIcon(order.status),
                              color: _getStatusColor(order.status),
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _getStatusText(order.status),
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: _getStatusColor(order.status),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow('Adresse', order.deliveryAddress),
                        const SizedBox(height: 8),
                        _buildInfoRow('Total',
                            '${order.grandTotal.toStringAsFixed(0)} DH'),
                        const SizedBox(height: 8),
                        _buildInfoRow(
                            'Méthode de paiement', 'Paiement à la livraison'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Google Maps Section
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Suivi en temps réel',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: GoogleMap(
                            initialCameraPosition: const CameraPosition(
                              target: LatLng(
                                  33.5731, -7.5898), // Casablanca coordinates
                              zoom: 12,
                            ),
                            markers: {
                              Marker(
                                markerId: const MarkerId('restaurant'),
                                position: const LatLng(33.5731, -7.5898),
                                infoWindow:
                                    const InfoWindow(title: 'Restaurant'),
                              ),
                              Marker(
                                markerId: const MarkerId('delivery'),
                                position: const LatLng(33.5725, -7.5890),
                                infoWindow: const InfoWindow(title: 'Livreur'),
                                icon: BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueGreen),
                              ),
                            },
                            myLocationEnabled: false,
                            myLocationButtonEnabled: false,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Votre commande est en route',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Call Driver Button
                if (_shouldShowCallButton(order.status))
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _callDriver(context),
                      icon: const Icon(Icons.phone),
                      label: const Text('Appeler le livreur (05227-09807)'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            '$label:',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'En attente de confirmation';
      case OrderStatus.confirmed:
        return 'Commande confirmée';
      case OrderStatus.preparing:
        return 'En préparation';
      case OrderStatus.ready:
        return 'Prête pour livraison';
      case OrderStatus.pickedUp:
        return 'Récupérée par le livreur';
      case OrderStatus.onTheWay:
        return 'En cours de livraison';
      case OrderStatus.delivered:
        return 'Livrée';
      case OrderStatus.cancelled:
        return 'Annulée';
    }
  }

  bool _shouldShowCallButton(OrderStatus status) {
    return status.index >= OrderStatus.pickedUp.index &&
        status != OrderStatus.delivered &&
        status != OrderStatus.cancelled;
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.delivered:
        return AppColors.success;
      case OrderStatus.cancelled:
        return AppColors.error;
      case OrderStatus.onTheWay:
        return AppColors.accent;
      case OrderStatus.pickedUp:
        return const Color(0xFFF39C12);
      default:
        return AppColors.textPrimary;
    }
  }

  IconData _getStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Icons.access_time;
      case OrderStatus.confirmed:
        return Icons.check_circle_outline;
      case OrderStatus.preparing:
        return Icons.restaurant;
      case OrderStatus.ready:
        return Icons.assignment_turned_in;
      case OrderStatus.pickedUp:
        return Icons.delivery_dining;
      case OrderStatus.onTheWay:
        return Icons.directions_bike;
      case OrderStatus.delivered:
        return Icons.verified;
      case OrderStatus.cancelled:
        return Icons.cancel;
    }
  }
}
