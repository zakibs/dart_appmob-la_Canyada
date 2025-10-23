import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/theme_provider.dart';
import '../../providers/auth_provider.dart'; // Import manquant

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: currentUser.when(
        data: (user) {
          final isLoggedIn = user != null;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.primary,
                        child:
                            Icon(Icons.person, size: 40, color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        isLoggedIn ? user.name ?? user.email : 'Invité',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isLoggedIn
                            ? user.email
                            : 'Connectez-vous pour profiter de toutes les fonctionnalités',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      if (!isLoggedIn)
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Se connecter'),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Column(
                  children: [
                    if (isLoggedIn) ...[
                      ListTile(
                        leading:
                            const Icon(Icons.history, color: AppColors.primary),
                        title: const Text('Mes commandes'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          // Naviguer vers la page des commandes
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.favorite,
                            color: AppColors.primary),
                        title: const Text('Mes favoris'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.location_on,
                          color: AppColors.primary,
                        ),
                        title: const Text('Mes adresses'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {},
                      ),
                      const Divider(),
                    ],
                    ListTile(
                      leading:
                          const Icon(Icons.settings, color: AppColors.primary),
                      title: const Text('Paramètres'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                    ListTile(
                      leading:
                          const Icon(Icons.dark_mode, color: AppColors.primary),
                      title: const Text('Thème sombre'),
                      trailing: Switch(
                        value: ref.watch(themeProvider).themeMode ==
                            ThemeMode.dark,
                        onChanged: (value) {
                          ref.read(themeProvider.notifier).toggleTheme();
                        },
                      ),
                    ),
                    if (isLoggedIn)
                      ListTile(
                        leading:
                            const Icon(Icons.logout, color: AppColors.error),
                        title: const Text('Déconnexion'),
                        onTap: () {
                          _showLogoutDialog(context, ref);
                        },
                      ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: AppColors.error, size: 50),
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
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authRepositoryProvider).signOut();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Déconnexion'),
          ),
        ],
      ),
    );
  }
}
