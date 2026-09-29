import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/activity_provider.dart';

class ActivityDetailScreen extends StatelessWidget {
  final String activityId;

  const ActivityDetailScreen({super.key, required this.activityId});

  // Dialog Konfirmasi Hapus
  void _showDeleteDialog(BuildContext context, ActivityProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFFF3E5F5),
        title: const Text(
          'Konfirmasi Hapus',
          style: TextStyle(color: Color(0xFF2A085C), fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Apakah Anda yakin ingin menghapus aktivitas ini?',
          style: TextStyle(color: Color(0xFF4A1584)),
        ),
        actions: [
          TextButton(
            child: const Text('Batal', style: TextStyle(color: Color(0xFF4A1584))),
            onPressed: () => Navigator.of(ctx).pop(), // Tutup dialog saja
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
            onPressed: () {
              // 1. Hapus data dari state (memperbarui daftar di Provider)
              provider.deleteActivity(activityId);

              // 2. Tutup dialog
              Navigator.of(ctx).pop();

              // 3. Kembali ke layar sebelumnya (ActivityListScreen)
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/activities');
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ActivityProvider>(context);
    final activity = provider.findById(activityId);

    if (activity == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF4A1584),
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Detail Aktivitas', style: TextStyle(color: Colors.white)),
        ),
        body: const Center(
          child: Text('Aktivitas tidak ditemukan.', style: TextStyle(color: Colors.white70)),
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4A1584),
              Color(0xFF7B2CBF),
              Color(0xFFE8D7FF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom Header / AppBar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/activities');
                        }
                      },
                    ),
                    Expanded(
                      child: Text(
                        activity.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // TOMBOL HAPUS DENGAN DIALOG KONFIRMASI
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => _showDeleteDialog(context, provider),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Kartu Detail Aktivitas
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9), // Krem/Putih transparan lembut
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Badge Kategori
                          Chip(
                            backgroundColor: const Color(0xFFE8D7FF),
                            label: Text(
                              activity.category,
                              style: const TextStyle(
                                color: Color(0xFF4A1584),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Status Aktivitas
                          Text(
                            'Status: ${activity.isCompleted ? "Selesai" : "Belum Selesai"}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2A085C),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Divider(color: Color(0xFFCE93D8)),
                          const SizedBox(height: 8),
                          // Deskripsi Aktivitas
                          Text(
                            activity.description,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF2A085C),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}