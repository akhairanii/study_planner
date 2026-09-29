import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2A085C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
        title: const Text(
          'Profil Pengguna',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            // Profil Utama
            Stack(
              alignment: Alignment.topCenter,
              children: [
                // Kartu Informasi
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 50.0),
                  padding: const EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 20.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3E5F5),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Column(
                    children: [
                      Text(
                        'Annisa Khairani',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2A085C),
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'NIM: 241401022',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF4A1584),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Mata Kuliah: Pemrograman Mobile',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF4A1584),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Lingkaran Avatar Foto Profil
                Positioned(
                  top: 0,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(0xFFE8D7FF),
                    child: const CircleAvatar(
                      radius: 46,
                      backgroundColor: Color(0xFFCE93D8),
                      child: Icon(
                        Icons.person,
                        size: 55,
                        color: Color(0xFF2A085C),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // KARTU PROGRES BELAJAR
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progres Belajar (Flutter)',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4A1584),
                        ),
                      ),
                      Icon(Icons.rocket_launch, color: Color(0xFF7B2CBF), size: 20),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0.78, // Persentase progres 78%
                      minHeight: 14,
                      backgroundColor: const Color(0xFFE8D7FF),
                      color: const Color(0xFF7B2CBF),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Dasar', style: TextStyle(fontSize: 11, color: Colors.grey)),
                      Text('Widget', style: TextStyle(fontSize: 11, color: Colors.grey)),
                      Text('State', style: TextStyle(fontSize: 11, color: Colors.grey)),
                      Text('78%', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF7B2CBF))),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // AKTIVITAS TERBARU (Mengisi Penuh Lebar Layar)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Aktivitas Terbaru',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A1584),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildActivityBadge('✓ Selesai Kuis Kalkulus'),
                  _buildActivityBadge('✓ Submit Proyek Grammar'),
                  _buildActivityBadge('✓ Baca Unit State Mgt'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget untuk Item Aktivitas
  static Widget _buildActivityBadge(String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFF4A1584),
        ),
      ),
    );
  }
}