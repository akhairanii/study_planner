import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/activity_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ActivityProvider>(context);

    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF2A085C),
                Color(0xFF4A1584),
                Color(0xFF7B2CBF),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul Aplikasi
                  const Text(
                    'Study Planner ♡',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Beranda',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Expanded(
                    child: Column(
                      children: [
                        // Box Ringkasan Aktivitas
                        Expanded(
                          flex: 3,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 16,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF0E6FF),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.track_changes, color: Color(0xFF6C2BD9)),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Ringkasan Aktivitas',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2A085C),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildStatItem(
                                      icon: Icons.calendar_today_rounded,
                                      label: 'Total Aktivitas',
                                      value: provider.activities.length.toString(),
                                      iconBgColor: const Color(0xFFEDE7F6),
                                      iconColor: const Color(0xFF6C2BD9),
                                    ),
                                    _buildStatItem(
                                      icon: Icons.check_circle_rounded,
                                      label: 'Selesai',
                                      value: provider.completedCount.toString(),
                                      iconBgColor: const Color(0xFFE8F5E9),
                                      iconColor: const Color(0xFF2E7D32),
                                    ),
                                    _buildStatItem(
                                      icon: Icons.star_rounded,
                                      label: 'Favorit',
                                      value: provider.favoriteActivities.length.toString(),
                                      iconBgColor: const Color(0xFFFFF0F5),
                                      iconColor: const Color(0xFFD81B60),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Tombol NavigasiDaftar Aktivitas
                        Expanded(
                          flex: 2,
                          child: _buildMenuButton(
                            context,
                            title: 'Daftar Aktivitas',
                            icon: Icons.format_list_bulleted_rounded,
                            iconColor: const Color(0xFF6C2BD9),
                            iconBgColor: const Color(0xFFCBADF8),
                            onTap: () => context.push('/activities'),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Tombol Navigasi Aktivitas Favorit
                        Expanded(
                          flex: 2,
                          child: _buildMenuButton(
                            context,
                            title: 'Aktivitas Favorit',
                            icon: Icons.favorite_rounded,
                            iconColor: Colors.white,
                            iconBgColor: const Color(0xFFE91E63),
                            onTap: () => context.push('/favorites'),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Tombol NavigasiProfil Saya
                        Expanded(
                          flex: 2,
                          child: _buildMenuButton(
                            context,
                            title: 'Profil Saya',
                            icon: Icons.person_rounded,
                            iconColor: Colors.white,
                            iconBgColor: const Color(0xFF8E24AA),
                            onTap: () => context.push('/profile'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color iconBgColor,
    required Color iconColor,
    String? imagePath,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconBgColor,
            shape: BoxShape.circle,
          ),
          child: imagePath != null
              ? Image.asset(imagePath, width: 22, height: 22, fit: BoxFit.contain)
              : Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF616161),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: iconColor,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuButton(
      BuildContext context, {
        required String title,
        required IconData icon,
        required Color iconColor,
        required Color iconBgColor,
        required VoidCallback onTap,
        String? imagePath,
      }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: imagePath != null
                      ? Image.asset(imagePath, width: 24, height: 24, fit: BoxFit.contain)
                      : Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2A085C),
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF7B2CBF),
                  size: 28,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}